from skimage.transform import rotate
from skimage.feature import local_binary_pattern
from skimage import data,io,data_dir,filters, feature
from skimage.color import label2rgb
import skimage
import matplotlib.pyplot as plt
from PIL import Image

import cv2
import numpy as np
import random
import glob
import copy

def Variance_compare(LBP_1,LBP_2,cluster_num):
    lbp_cluster_piece = (np.power(2,n_points)-1) / cluster_num
    LBP_Hist_1 = np.zeros((cluster_num),dtype=float)
    LBP_Hist_2 = np.zeros((cluster_num),dtype=float)

    for i in range(cluster_num):
        LBP_Hist_1[i] = len(LBP_1[(LBP_1 >= i * lbp_cluster_piece) & (LBP_1 < (i+1) * lbp_cluster_piece)])
        LBP_Hist_2[i] = len(LBP_2[(LBP_2 >= i * lbp_cluster_piece) & (LBP_2 < (i+1) * lbp_cluster_piece)])
    
    LBP_Hist_1 /= len(LBP_1)
    LBP_Hist_2 /= len(LBP_2)

    D0 = LBP_Hist_1 - LBP_Hist_2
    D0 = np.power(D0,2)
    D0 = np.sqrt(np.sum(D0))
    return D0

def Foe_located(im,flow,prefoex,prefoey,step=4):
    h,w = im.shape[:2]
    y,x = np.mgrid[step/2:h:step,step/2:w:step].reshape(2,-1).astype(int)
    fx,fy = flow[y,x].T
    # create line endpoints
    foex = prefoex
    foey = prefoey
    lines = np.vstack([x,y,x+fx,y+fy]).T.reshape(-1,2,2)
    lines = np.int32(lines)
    foe=np.zeros((height, width), np.uint8)
    foe1=np.zeros((height, width), np.uint8)
    # print(lines.shape)
    for (x1,y1),(x2,y2) in lines:

        if y1>int(height/2) and x1>int(width/4) and x1<int(width/4*3) :
            I = np.sqrt(np.square(x1-x2) + np.square(y1-y2))
            if (y1 < y2 and I>3) and ((x1<width/2 and x1>x2) or (x1>width/2 and x1<x2)):
                cv2.line(foe1, (x1-60*(x2-x1), y1-60*(y2-y1)),(x2,y2),1,1)
                foe += foe1
                foe1=np.zeros((height, width), np.uint8)

    foex =int(np.average(np.where(foe == np.max( foe ))[1])) 
    foey =int(np.average(np.where(foe == np.max( foe ))[0])) 
    foex_n =int(np.average(np.where(foe == np.max( foe ))[1])) 
    foey_n =int(np.average(np.where(foe == np.max( foe ))[0])) 

    if prefoex > 0 and prefoey > 0:
        foex = int(prefoex*0.8+foex*0.2)
        foey = int(prefoey*0.8+foey*0.2)

    # cv2.namedWindow("foe",0)
    # cv2.imshow("foe",foe) #原始影片
    
    print("foex = ",np.average(np.where(foe == np.max( foe ))[1])) 
    print("foey = ",np.average(np.where(foe == np.max( foe ))[0]))  

    return foex,foey,foex_n,foey_n

def Foe_estimate_road(flow,foex, foey,foex_n,foey_n): 
    vis=np.zeros((height, width), np.uint8)  
    minxl = 0
    minxl1 = 0
    minxr = int(width/3*2)
    r =10

    for x in range (width//2,0,-1):
        x2,y2 = flow[height-1,x].T
        x2 += x
        y2 += (height-1)
        dis = getDis(foex_n,foey_n,x,height-1,x2,y2)
        # print(dis)
        if dis<20:
            # print(dis)
            minxl1 = x
            minxl = minxl1
    for x in range (width//2,width,1):
        x2,y2 = flow[height-1,x].T
        x2 += x
        y2 += (height-1)
        dis = getDis(foex_n,foey_n,x,height-1,x2,y2)
        # print(dis)
        if dis<20:
            # print(dis)
            minxr = x  

    for i in range(minxl,minxr,1):
        cv2.line(vis, (foex, foey-r),(i,height),255,1)

    return vis

def check_flow(vis,foeroad,flow,foex_n,foey_n):
    for x in range(4,width,4):
        for y in range(foey+15,height,4):
            if foeroad[y,x] == 255 and vis[y,x] == 0:
                x2,y2 = flow[y,x].T
                x2 += x
                y2 += y
                I = np.sqrt(np.square(x-x2) + np.square(y-y2))
                dis = getDis(foex_n,foey_n,x,y,x2,y2)
                if I < (5/(height-foey))*(y-foey) or dis < (20/(height-foey))*(y)-foey :  #(dis <(y-foey)/50 and I > (y-foey)/40) oror (dis<5 and y>(foey + ((height-foey)/2) ))
                    x2 = int(x2)
                    y2 = int(y2)
                    vis[y-4:y+4,x-4:x+4] = 255
                elif I < (y-foey)/40 and x<width/2:
                    x2 = int(x2)
                    y2 = int(y2)
                    vis[y-4:y+4,x-4:x+4] = 255
    for t in range(0,3,1):
        for x in range(10,width-10,4):
            for y in range(foey+15,height-10,4):
                x2,y2 = flow[y,x].T
                x2 += x
                y2 += y
                I = np.sqrt(np.square(x-x2) + np.square(y-y2))
                if (foeroad[y,x] == 255 and vis[y,x] == 0  ) :
                    if  (any(vis[foey:y,x] == 255) and any(vis[y,0:x]== 255) and any(vis[y,x:width] == 255)) or (any(vis[foey:y,x] == 255) and any(vis[y:height-1,x] == 255) and any(vis[y,0:x] == 255)) and I<5:
                        vis[y-4:y+4,x-4:x+4] = 255
                    elif (any(vis[y,x-10:x]== 255) and any(vis[y,x:x+10] == 255)) or (any(vis[y-10:y,x]== 255) and any(vis[y:y+10,x] == 255)) and I<5:
                        vis[y-4:y+4,x-4:x+4] = 255
        
    return vis

def others_deep(im,road,foeroad,flow,foex_n,foey_n):
    maxdeep = 0
    mindeep = 255
    maxd= 0
    for x in range(0,width,4):
        for y in range(0,height,4):
            if  road[y,x] == 0 :#and x != foex and y != foey :#foeroad[y,x] == 255 and
                x2,y2 = flow[y,x].T
                x2 += x
                y2 += y
                I = np.sqrt(np.square(x-x2) + np.square(y-y2))
           
                d = np.sqrt(np.square(x-foex) + np.square(y-foey))
                
                if  I>d/150 :#and dis > 10:  #(dis <(y-foey)/50 and I > (y-foey)/40) or  I >=(20/(height-foey))*(y-foey)  dis > (30/(height-foey))*(y)-foey:
                    # im[y,x] = (0,int((y-foey)/(height-foey)*255),0)
                    if (d/I) > maxdeep:
                        maxdeep = (d/I)
                    if (d/I) < mindeep:
                        mindeep = (d/I)
                    if d > maxd:
                        maxd = d

    for x in range(5,width,4):
        for y in range(5,height-5,4):
            if  road[y,x] == 0 :#and x != foex and y != foey :#foeroad[y,x] == 255 and
                x2,y2 = flow[y,x].T
                x2 += x
                y2 += y
                I = np.sqrt(np.square(x-x2) + np.square(y-y2))
                d = np.sqrt(np.square(x-foex) + np.square(y-foey))
                if  I>d/150 :#and dis> 120:#and dis > 10:  #(dis <(y-foey)/50 and I > (y-foey)/40) or  I >=(20/(height-foey))*(y-foey)  dis > (30/(height-foey))*(y)-foey:
                    deep = (255-int(255/(maxdeep-mindeep)*((d/I)-mindeep)))
                    im[y-4:y+4,x-4:x+4] = (0,int(d/maxd * deep),0) 
        
    return im

def getDis(pointX,pointY,lineX1,lineY1,lineX2,lineY2):
    a=lineY2-lineY1
    b=lineX1-lineX2
    c=lineX2*lineY1-lineX1*lineY2
    dis=(np.fabs(a*pointX+b*pointY+c))/(np.sqrt((a*a+b*b)))
    return dis

# fourcc = 0x00000021 #存取影片
# cv2.VideoWriter_fourcc('H', '2', '6', '4')
# videoWriter = cv2.VideoWriter('./cut3.mp4', fourcc , 24, (1392,512)) # 建立 VideoWriter 物件，輸出影片至 output.avi ,falus

# cap = cv2.VideoCapture('D:\F222\Road_project_API\data1\data1.mp4')
# length = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
# width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
# height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
# FPS = int(cap.get(cv2.CAP_PROP_FPS))
# print("Image Size: %d x %d , %d" % (width, height, FPS))



imgs = glob.glob("D:/F222/Road_project_API/N04-TestReport/data1/0000000???.png")
img = cv2.imread(imgs[0])
height,width=img.shape[:2]
length=len(imgs)
print("Image Size: %d x %d" % (width, height))

radius = 1 # LBP算法中范围半径的取值
n_points = 8* radius  # 领域像素点
videocount=0

kernel_size = 15 ####
kernel_range = kernel_size // 2

marker_0 = np.zeros((height,width),np.uint8) ##用來做LBP重疊
marker_1 = np.zeros((height,width),np.uint8) ##

foex,foey = 0,0

###main-------------------------------------------------------------------------------------------------------------------------------------------------------
for imgname in imgs:

    print(" %d / %d " % (videocount, length))

    image = cv2.imread(imgname)
    gray= cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # cv2.namedWindow("gray",0)
    # cv2.imshow('gray',gray)
    lbp = local_binary_pattern(gray, n_points, radius)
    
    marker = np.zeros((height,width),np.uint8)
    ##########LBP marker 重疊###########
    if videocount%2 == 0 :
        marker = marker_1
        marker_0 = np.zeros((height,width),np.uint8)
    elif videocount%2 == 1 :
        marker = marker_0
        marker_1 = np.zeros((height,width),np.uint8)
    ##########LBP比對########### LBP Compare Marker
    for w in range((kernel_size*2),(width-kernel_size),kernel_range):
        for h in range((kernel_size*2),(height-kernel_size),kernel_range):
            
            Diff1=Variance_compare(lbp[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range],lbp[h-kernel_range:h+kernel_range,w:w+(kernel_range*2)],32)
            #print("Diff1=",Diff1)
            Diff2=Variance_compare(lbp[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range],lbp[h:h+(kernel_range*2),w-kernel_range:w+kernel_range],32)
            #print("Diff2=",Diff2)
            Diff3=Variance_compare(lbp[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range],lbp[h-kernel_range:h+kernel_range,w-(kernel_range*2):w],32)
            #print("Diff3=",Diff3)
            Diff4=Variance_compare(lbp[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range],lbp[h-(kernel_range*2):h,w-kernel_range:w+kernel_range],32)
            #print("Diff4=",Diff4)
            
            # print("Diff_total = ",(Diff1+Diff2+Diff3+Diff4))
            if ((Diff1+Diff2+Diff3+Diff4)/4)<0.9:
                marker[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range] = 255
                marker_0[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range] = 255
                marker_1[h-kernel_range:h+kernel_range,w-kernel_range:w+kernel_range] = 255
    ##########邊緣 MAKER 標記###########
    marker[0:10,0:10] = 255
    marker[0:10,(width-10):width] = 255
    marker[(int(height/2)-5):(int(height/2)+5),0:10] = 255
    marker[(int(height/2)-5):(int(height/2)+5),(width-10):width] = 255
    marker[0:10,(int(width/3)):(int(width/3*2))] = 255

    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (11,11))
    marker = cv2.morphologyEx(marker, cv2.MORPH_CLOSE, kernel)
    
    cv2.imwrite('Results/1-marker/%d.jpg' %videocount,marker)

    # water shed---------------------------------------------------------------------------------
    sure_fg = np.uint8(marker)
    ret, markers = cv2.connectedComponents(sure_fg)

    markers = cv2.watershed(image,markers) 
    cut = np.zeros((height,width),np.uint8)
    cut[markers == -1] = [255]

    cv2.imwrite('Results/2-watershed1/%d.jpg' %videocount,cut)
    ###放大切割線條做標記--------------------------------------------------------------------------------

    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3,3))
   
    dilate = np.zeros((height,width),np.uint8)
    dilate = cv2.dilate(cut,kernel)

    dilate = 255- dilate

    ###connectedComponents-----------------------------------------------------------------------
    nlabels, labels, stats, centroids = cv2.connectedComponentsWithStats(dilate)
    max_size = 0 
    road_number = -1
    roadbase = np.zeros((height,width),np.uint8)
    ###找出最有可能是道路的區塊(靠近中間 靠近畫面下方 面積最大)(沒有找到就放大搜尋面積)estimate road-------------------------------------
    for i in range(0,nlabels-1,1):
        x,y = centroids[i]

        if  (y>(height/3*2)) and (x<((width/4)*3)) and (x>width/4) and np.all(dilate[labels==i] == 255 ): 
            if(dilate[labels==i].size > max_size):
                max_size =  dilate[labels==i].size 
                road_number = i

    if road_number == -1 :
        for i in range(0,nlabels-1,1):
            x,y = centroids[i]            
            if  (y>(height/2)) and (x<((width/3)*2)) and (x>width/3) and np.all(dilate[labels==i] == 255 ):
                if(dilate[labels==i].size > max_size):
                    max_size =  dilate[labels==i].size 
                    road_number = i

    if road_number == -1 :
        for i in range(0,nlabels-1,1):
            x,y = centroids[i]            
            if  (y>(height/3)) and (x<((width/4)*3)) and (x>width/4) and np.all(dilate[labels==i] == 255 ):
                if(dilate[labels==i].size > max_size):
                    max_size =  dilate[labels==i].size 
                    road_number = i

    # if road_number == -1 :
    #     for i in range(0,nlabels-1,1):
    #         x,y = centroids[i]            
    #         if  (y>(height/2)) and (x<((width/4)*3)) and (x>width/4) and np.all(dilate[labels==i] == 255 ):
    #             if(dilate[labels==i].size > max_size):
    #                 max_size =  dilate[labels==i].size 
    #                 road_number = i
    print ("road_number : ",road_number)

    roadbase[labels==road_number] = (255)
    cv2.imwrite('Results/3-roadbase/%d.jpg' %videocount ,roadbase)
    ###用找到的路面區塊跟其他的區塊LBP值比較-------------------------------------------------------------------
    for i in range(0,nlabels,1):
        x,y = centroids[i]
        Diff=Variance_compare(lbp[ labels==road_number],lbp[ (labels==i) & (dilate==255) ],32)      

        cv2.putText(cut, str(Diff), (int(x),int(y)), cv2.FONT_HERSHEY_SIMPLEX,  0.5, (255, 255,255), 1, cv2.LINE_AA)

        if (((y >  height/2) and (x<((width/3)*2)) and (x>width/3)) or ((y >  height/3*2) and (x<((width/4)*3)) and (x>width/4))) and np.all(dilate[labels==i] == 255 ):     
            if  Diff < 0.09 :
                # print("x : ",x,"y : ",y)
                # print(Diff)
                roadbase[ (labels==i)] = (255)
                cv2.putText(roadbase, str(Diff), (int(x),int(y)), cv2.FONT_HERSHEY_SIMPLEX,  0.5, (0, 0, 0), 1, cv2.LINE_AA)
        elif (y > height/4*3) and np.all(dilate[labels==i] == 255 ):
            if  Diff < 0.06 :
                # print("x : ",x,"y : ",y)
                # print(Diff)
                roadbase[ (labels==i)] = (255)
                cv2.putText(roadbase, str(Diff), (int(x),int(y)), cv2.FONT_HERSHEY_SIMPLEX,  0.5, (0, 0, 0), 1, cv2.LINE_AA)
        elif (y > height/5*4) and np.all(dilate[labels==i] == 255 ):
            if  Diff < 0.12 :
                # print("x : ",x,"y : ",y)
                # print(Diff)
                roadbase[ (labels==i)] = (255)
                cv2.putText(roadbase, str(Diff), (int(x),int(y)), cv2.FONT_HERSHEY_SIMPLEX,  0.5, (0, 0, 0), 1, cv2.LINE_AA)


    cv2.imwrite('Results/4-LBP_block_data/%d.jpg' % videocount ,cut)    
    cv2.imwrite('Results/5-roadbase2/%d.jpg' % videocount ,roadbase)
    ### close 填滿縫隙--Road merge---------------------------------------------------------------------------
    ret,roadbase = cv2.threshold(roadbase,127,255,cv2.THRESH_BINARY)

    kernel = np.ones((9,9),np.uint8)
    roadbase = cv2.morphologyEx(roadbase, cv2.MORPH_CLOSE, kernel,iterations = 5)
    roadbase = cv2.morphologyEx(roadbase, cv2.MORPH_OPEN, kernel)

    # cv2.namedWindow("labels3",0)
    # cv2.imshow("labels3", roadbase)
    # videoWriter.write(roadbase)
    roadbase = cv2.erode(roadbase,kernel,iterations = 5)

    #Marker merge-----------------------------------------------------------------------------------------
    marker[roadbase== 255] = 255 
    marker = cv2.morphologyEx(marker, cv2.MORPH_OPEN, kernel)
    cv2.imwrite('Results/6-marker2/%d.jpg' %videocount,marker)

    # water shed2---------------------------------------------------------------------------------
    sure_fg = np.uint8(marker)
    ret, markers = cv2.connectedComponents(sure_fg)

    markers = cv2.watershed(image,markers) 
    cut2 = np.zeros((height,width),np.uint8)
    cut2[markers == -1] = [255]
    ###---------------------------------------------------------------------------------------
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5,5))
    cut2 = cv2.dilate(cut2,kernel)
    cut2 = 255 - cut2
    # cv2.namedWindow("out2",0)
    # cv2.imshow("out2", cut2)
    cv2.imwrite('Results/7-watershed2/%d.jpg' % videocount ,cut2)
    ###connectedComponents-----------------------------------------------------------------------

    nlabels, labels, stats, centroids = cv2.connectedComponentsWithStats(cut2)
    max_size = 0 
    road_number = -1
    ###  找出道路位置------------------------------------------------------------------------------
    for i in range(0,nlabels-1,1):
        x,y = centroids[i]
        if  (y>(height/3*2)) and (x<((width/3)*2)) and (x>width/3) and np.all(cut2[labels==i] == 255 ):
            if(cut2[labels==i].size > max_size):
                max_size =  cut2[labels==i].size 
                road_number = i
    if road_number == -1 :
        for i in range(0,nlabels-1,1):
            x,y = centroids[i]
            if  (y>(height/2)) and (x<((width/3)*2)) and (x>width/3) and np.all(cut2[labels==i] == 255 ):
                if(cut2[labels==i].size > max_size):
                    max_size =  cut2[labels==i].size 
                    road_number = i
    # print ("road_number : ",road_number)
    out = np.zeros((height,width),np.uint8)
    out[labels==road_number] = (255)

    cv2.namedWindow("Results",0)
    cv2.imshow("Results", out)   
    cv2.imwrite('Results/8-road_segmentation/%d.jpg' % videocount ,out)

    image[labels==road_number] = (0,0,255)

    cv2.namedWindow("R",0)
    cv2.imshow("R", image)   
    cv2.imwrite('Results/9-road_segmentation_show/%d.jpg' % videocount ,image)
    
    ###光流分析------------------------------------------------------------------------------------------------------------
    im = cv2.imread(imgname)
    im2 = cv2.imread(imgname)
    new_gray = cv2.cvtColor(im,cv2.COLOR_BGR2GRAY) #灰階化
    if videocount> 0 :
        img_white = np.zeros((height, width,3), np.uint8)
        ###Farneback-------------------------------------------------------------------------------------------------------------
        flow = cv2.calcOpticalFlowFarneback(old_gray, new_gray, None, 0.5, 3, 10, 3, 5, 1.2, 0)
        print(flow.shape)

        ###Foe located 找FOE--------------------------------------------------------------------------------------
        foex,foey,foex_n,foey_n = Foe_located(im,flow,foex,foey) #找出FOE

        ###Foe estimate road-------------------------------------------------------------------------------
        road=np.zeros((height, width), np.uint8)
        foeroad = np.zeros((height, width), np.uint8)
        putroad=np.zeros((height, width,3), np.uint8)
        foeroad = Foe_estimate_road(flow,foex, foey,foex_n,foey_n)
        
        ####Compare LBP road and Optical Flow------------------------------------------------------------------------------------
        road[(foeroad==255) & (out == 255)] =255
        #####
        kernel = np.ones((3,3),np.uint8)
        road = cv2.morphologyEx(road, cv2.MORPH_CLOSE, kernel)
        #####
        road = check_flow(road,foeroad,flow,foex_n,foey_n)

        for y in range(foey,height,1):
            for x in range(0,width,1):
                if road[y,x]==255: 
                    putroad[y,x] = (0,0,int((y-foey)/(height-foey)*255))
                    im[y,x] = (0,0,int((y-foey)/(height-foey)*255))

        putroad = others_deep(putroad,road,foeroad,flow,foex_n,foey_n) 
        im = others_deep(im,road,foeroad,flow,foex_n,foey_n) 

        im2 = cv2.addWeighted(im2, 0.3, putroad, 0.7, 0)

        # cv2.circle(im,(foex, foey), 1, (255, 255, 255), 5)
        # print (OpticalFlow_image.shape)
        # cv2.namedWindow("Image",0)
        # cv2.namedWindow("OpticalFlow",0)
        # cv2.namedWindow("out",0)
        # cv2.namedWindow("im",0)

        # cv2.imshow("im",im) #原始影片
        # cv2.imshow("Image",old_gray) #原始影片
        # cv2.imshow('OpticalFlow',foeroad) 
        # cv2.imshow("out",road) #原始影片
        cv2.imwrite('Results/10-output1/%d.jpg' % videocount ,im)
        cv2.imwrite('Results/11-output2/%d.jpg' % videocount ,im2)
        # videoWriter.write(im) #輸出影片 要等...data4_R3_15_Farneback

    old_gray = new_gray # 第一幀 = 第二幀    
    videocount +=1
    if cv2.waitKey(10) == 27:
        break
    cv2.waitKey(1)

# videoWriter.release()
cv2.destroyAllWindows() 

