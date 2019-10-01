function varargout = EthioCarPlate(varargin)
% ETHIOCARPLATE MATLAB code for EthioCarPlate.fig
%      ETHIOCARPLATE, by itself, creates a new ETHIOCARPLATE or raises the existing
%      singleton*.
%
%      H = ETHIOCARPLATE returns the handle to a new ETHIOCARPLATE or the handle to
%      the existing singleton*.
%
%      ETHIOCARPLATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ETHIOCARPLATE.M with the given input arguments.
%
%      ETHIOCARPLATE('Property','Value',...) creates a new ETHIOCARPLATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EthioCarPlate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EthioCarPlate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EthioCarPlate

% Last Modified by GUIDE v2.5 21-Jan-2013 02:27:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EthioCarPlate_OpeningFcn, ...
                   'gui_OutputFcn',  @EthioCarPlate_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before EthioCarPlate is made visible.
function EthioCarPlate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EthioCarPlate (see VARARGIN)

% Choose default command line output for EthioCarPlate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EthioCarPlate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EthioCarPlate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


folder=pwd;
	cd(folder); 
	[baseFileName, folder] = uigetfile('*.*', 'Specify an image file'); 
      I=imread(baseFileName); 
      axes(handles.axes1);
      imshow(I);
      handles.img = I; % Store the img data in the handles struct
      handles.I_orig =I;%creating Global var
      guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%----------------Preprocessing start
I = handles.img;
%---extracting each layers
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%--median filter in each layers
RF=medfilt2(R);
GF=medfilt2(G);
BF=medfilt2(B);

 axes(handles.axes2);
 imshow(RF);
 axes(handles.axes3);
 imshow(GF);
 axes(handles.axes4);
 imshow(BF);
 
I_filt = cat(3,RF,GF,BF);% combine all filtered layers
axes(handles.axes5);
 imshow(I_filt);
 handles.img = I_filt;%creating the variable img in handle struct
 guidata(hObject, handles);
%================Preprocessing end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%----------------Segmentation
I_filt = handles.img;%calling global var
coins_seg_bw=adaptivethreshold(I_filt,100,0.03);
axes(handles.axes6);
 imshow(coins_seg_bw);
 handles.img = coins_seg_bw;%creating golobal var
 guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%------------Filling holes
coins_seg_bw = handles.img;%calling global var
fillhole= imfill( coins_seg_bw,'holes');
axes(handles.axes7);
 imshow(fillhole);
 handles.img = fillhole;%creating golobal var
 guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fillhole = handles.img;
remove_false_reg = bwareaopen(fillhole,65);
axes(handles.axes8);
 imshow(remove_false_reg);
 handles.img_bw = remove_false_reg;%creating golobal var
 guidata(hObject, handles);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%---extracting the region of interest (RGB coins) 
I=handles.I_orig;%Using Global var
remove_false_reg=handles.img ;%Using golobal var

I_seg_rgb = bsxfun(@times, I, cast(remove_false_reg,class(I)));

axes(handles.axes9);
 imshow(I_seg_rgb);
 handles.img_rgb = I_seg_rgb;%creating golobal var
 
 global x
       x=1;
      handles.x=x;
 guidata(hObject, handles);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



valNN={};
I_seg_rgb= handles.img_rgb; % Using golobal var
remove_false_reg = handles.img_bw;% Using golobal var
I=handles.I_orig ;%creating Global var

net=handles.netDAT; %creating golobal var
%net=load('Trained_network.mat');%load('Trained_network.mat')

 
 %feature extraction
        %Color features
        Red_i =I_seg_rgb(:,:,1);
		Green_i =I_seg_rgb(:,:,2);
		Blue_i =I_seg_rgb(:,:,3);
		mean_R_i=mean2(Red_i);
		mean_G_i=mean2(Green_i);
		mean_B_i=mean2(Blue_i);
		[hue,s,v]=rgb2hsv(I_seg_rgb);%Coversion of RGB to HSV
		mean_h=mean2(hue);
		mean_s=mean2(s);
		mean_v=mean2(v);
        %Texture feature extraction
		i_rgb=I_seg_rgb;
		i_gray=rgb2gray(i_rgb);
		T=statxture(i_gray);
        
		%End of texture feature extraction 
		
		%Shape and size features extraction
		thresh_level=graythresh(i_gray);
		i_bw=im2bw(i_gray,thresh_level);
		attributes=regionprops(i_bw,'All');
		
		Area=attributes(1).Area;
		MajorAxisLengcell_indexh=attributes(1).MajorAxisLength;
		MinorAxisLength=attributes(1).MinorAxisLength;
		Eccentricity=attributes(1).Eccentricity;
		Perimeter=attributes(1).Perimeter;
		Ornt=attributes(1).Orientation;
		Solidity=attributes(1).Solidity;
        %End of Shape and size features extraction
        VAL={mean_R_i,mean_G_i,mean_B_i,mean_h,mean_s,mean_v,T(1),T(2),T(3),T(4),T(5),T(6),Area,MajorAxisLengcell_indexh,MinorAxisLength,Eccentricity,Perimeter,Ornt,Solidity};
        
		test=VAL;
        test=cell2mat(test);
        %Testing the Neural Network 
            
        [a,b]=max(sim(net,test'));
        numNN=round(a);
        if(numNN <= 100 && numNN >= 0)
           valNN=numNN;
        end
            
	 valNN
      
%Displaying the result in the orginal image

[LL,nn]=bwlabel(remove_false_reg);
ss = regionprops(LL,'Centroid');
cla(handles.axes12);%Removing the prev coin image from the axes12
axes(handles.axes12);
 imshow(I);  
 if(valNN==1)
       set(handles.text6,'String','AA');
       elseif(valNN==2)
         set(handles.text6,'String','AM'); 
       elseif(valNN==3)
         set(handles.text6,'String','OR'); 
       elseif(valNN==4)
       set(handles.text6,'String','ET');
       elseif(valNN==5)
        set(handles.text6,'String','UN'); 
 else
      set(handles.text6,'String','UNDEINED'); 
 end        
%
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%------Loading features from the database for training

conn=dbcon();
try      

e1=exec(conn,'select All cf1,cf2,cf3,cf4,cf5,cf6,tf1,tf2,tf3,tf4,tf5,tf6,gf1,gf2,gf3,gf4,gf5,gf6,gf7  FROM plate_features');
e1=fetch(e1);
input=get(e1,'Data');
%display this in to the table 
tab_input=cell2mat(input);

e=exec(conn,'select All class  FROM plate_features');
e=fetch(e);
output=get(e,'Data');

input=cell2mat(input');
output=cell2mat(output');
set(handles.output,'Visible','on');
set(handles.uitable2, 'data', tab_input)
handles.op=output;
handles.ip=input;

    catch ME
    switch ME.identifier
        case 'MATLAB:UndefinedFunction'
            warning('Function is undefined.  Assigning a value of NaN.');
        case 'MATLAB:scriptNotAFunction'
            warning(['Attempting to execute script as function. '...
                'Running script and assigning output a value of 0.']);
            notaFunction;
        otherwise
%             warning('error')
            rethrow(ME)       
    end
end

guidata(hObject, handles);



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.output,'Visible','off');
output=handles.op;
input=handles.ip;
 axes(handles.axes11);
 imshow(imread('ANN.jpg'));
 %###### Nural network    
net = newff(input,output ,[40], {'logsig'});
net.divideParam.trainRatio = 0.8; % training set [%]
net.divideParam.valRatio = 0.1; % validation set [%]
net.divideParam.testRatio = 0.1; % test set [%] 
net.trainparam.epoch = 1000;
net.trainparam.goal = 0.000001;
net.trainparam.lr = 0.00001;
[net,tr,Y,E] = train(net,input,output);
handles.netDAT = net;%creating golobal var
%######
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%set(handles.output,'Visible','on');
%set(handles.text10,'Visible','off');
I_seg_rgb= handles.img_rgb; % Using golobal var
remove_false_reg = handles.img_bw;% Using golobal var
I=handles.I_orig;%Using Global var
x=handles.x;
%


axes(handles.axes10);
 imshow(I_seg_rgb);
 % getting the selected item from popupmenu 
 contents=get(handles.popupmenu1,'String');
value=contents{get(handles.popupmenu1,'Value')};
 if( strcmp(value, 'AM'))
     result=1;
 elseif( strcmp(value, 'ET'))
     result=2;
 elseif(strcmp(value,'OR'))
     result=3;
 elseif(strcmp(value,'AA'))
     result=4;
 elseif(strcmp(value,'UN'))
     result=5;
 else
     result=0;%for Old Plates/any other plates
end
 
 %feature exstraction
        %Color features
        Red_i =I_seg_rgb(:,:,1);
		Green_i =I_seg_rgb(:,:,2);
		Blue_i =I_seg_rgb(:,:,3);
		mean_R_i=mean2(Red_i);
		mean_G_i=mean2(Green_i);
		mean_B_i=mean2(Blue_i);
		[hue,s,v]=rgb2hsv(I_seg_rgb);%Coversion of RGB to HSV
		mean_h=mean2(hue);
		mean_s=mean2(s);
		mean_v=mean2(v);
        %
        %Texture feature extraction
		i_rgb=I_seg_rgb;
		i_gray=rgb2gray(i_rgb);
		T=statxture(i_gray);
        
		%End of texture feature extraction 
		
		%Shape and size features extraction
		thresh_level=graythresh(i_gray);
		i_bw=im2bw(i_gray,thresh_level);
		attributes=regionprops(i_bw,'All');
		
		Area=attributes(1).Area;
		MajorAxisLengcell_indexh=attributes(1).MajorAxisLength;
		MinorAxisLength=attributes(1).MinorAxisLength;
		Eccentricity=attributes(1).Eccentricity;
		Perimeter=attributes(1).Perimeter;
		Ornt=attributes(1).Orientation;
		Solidity=attributes(1).Solidity;
        %End of Shape and size features extraction
        exdat={mean_R_i,mean_G_i,mean_B_i,mean_h,mean_s,mean_v,T(1),T(2),T(3),T(4),T(5),T(6),Area,MajorAxisLengcell_indexh,MinorAxisLength,Eccentricity,Perimeter,Ornt,Solidity,result};
 set(handles.uitable1, 'data', exdat);
 handles.dat=exdat;
 guidata(hObject, handles);
 %


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%saving features in the DB
         exdat=handles.dat;
         cla(handles.axes10);
         all_atrib={'cf1','cf2','cf3','cf4','cf5','cf6','tf1','tf2','tf3','tf4','tf5','tf6','gf1','gf2','gf3','gf4','gf5','gf6','gf7','class'};
         x=handles.x;
         x= x +1;
         conn=dbcon();  
         

try
    
    fastinsert(conn,'plate_features',all_atrib,exdat);
    set(handles.text10,'Visible','off');
    catch ME
    switch ME.identifier
        case 'MATLAB:UndefinedFunction'
            warning('Function is undefined.  Assigning a value of NaN.');
             case 'MATLAB:scriptNotAFunction'
            warning(['Attempting to execute script as function. '...
                'Running script and assigning output a value of 0.']);
            notaFunction;
        otherwise
%             warning('error')
            rethrow(ME)
            
    end
 
 end

close(conn);
handles.x=x;
guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


x=handles.x;
 x= x +1;
 handles.x=x;
guidata(hObject, handles);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Members;
%axes(handles.Members.axes2)
%imshow('logo.jpg')
