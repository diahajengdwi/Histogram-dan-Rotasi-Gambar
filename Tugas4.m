function varargout = Tugas4(varargin)
% TUGAS4 MATLAB code for Tugas4.fig
%      TUGAS4, by itself, creates a new TUGAS4 or raises the existing
%      singleton*.
%
%      H = TUGAS4 returns the handle to a new TUGAS4 or the handle to
%      the existing singleton*.
%
%      TUGAS4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUGAS4.M with the given input arguments.
%
%      TUGAS4('Property','Value',...) creates a new TUGAS4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tugas4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tugas4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tugas4

% Last Modified by GUIDE v2.5 28-Feb-2018 16:07:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tugas4_OpeningFcn, ...
                   'gui_OutputFcn',  @Tugas4_OutputFcn, ...
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


% --- Executes just before Tugas4 is made visible.
function Tugas4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tugas4 (see VARARGIN)

% Choose default command line output for Tugas4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tugas4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tugas4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnbrowse.
function btnbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namafile, formatfile] = uigetfile({'*.jpg','*.png'}, 'Pilih Gambar'); % memilih gambar
global image
image = imread([formatfile, namafile]); % membaca gambar
guidata(hObject, handles);
axes(handles.axes1); % memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); % memunculkan gambar


% --- Executes on button press in btnhistogram.
function btnhistogram_Callback(hObject, eventdata, handles)
% hObject    handle to btnhistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

% red
Red = cat(3,R,G*0,B*0);
[rows,cols] = size(R); 

% histogram array
myhist = zeros(256,1);
for k = 0 : 255
    myhist(k+1) = numel(find(R == k)); % number of element dimana ada gray level = 'k'
end
figure, stem(myhist,'r');
set(gca,'XLim',[0 255])
xlabel('Gray Level')
ylabel('Number of Elements')
title('Histogram of Image')
grid on
 
% Green 
Green = cat(3,R*0,G,B*0);
[rows,cols] = size(G); 

% histogram array
myhist = zeros(256,1);
for k = 0 : 255
    myhist(k+1) = numel(find(G == k)); % number of element dimana ada gray level = 'k'
end
figure, stem(myhist,'g');
set(gca,'XLim',[0 255])
xlabel('Gray Level')
ylabel('Number of Elements')
title('Histogram of Image')
grid on
 
% blue 
Blue = cat(3,R*0,G*0,B);
[rows,cols] = size(B); 

% histogram array
myhist = zeros(256,1);
for k = 0 : 255
    myhist(k+1) = numel(find(B == k)); % number of element dimana ada gray level = 'k'
end
figure, stem(myhist,'b');
set(gca,'XLim',[0 255])
xlabel('Gray Level')
ylabel('Number of Elements')
title('Histogram of Image')
grid on

% --- Executes on button press in btn90.
function btn90_Callback(hObject, eventdata, handles)
% hObject    handle to btn90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[rowsi,colsi,z]= size(image); 

sudut = 90;
rads = 2 * pi * sudut / 360;  

% menghitung dimesi array agar gambar yang diputar akan sesuai dengan yg didalamnya
% menggunakan absolute agar bisa mendapatkan nilai positif 
rowsf = ceil(rowsi * abs(cos(rads)) + colsi * abs(sin(rads)));                      
colsf = ceil(rowsi * abs(sin(rads)) + colsi * abs(cos(rads)));                     

% menentukan array dengan parameter yang dihitung dan isi array dengan angka nol
C = uint8(zeros([rowsf colsf 3 ]));

% menghitung center of original and final image
xo = ceil(rowsi / 2);                                                            
yo = ceil(colsi / 2);

midx = ceil((size(C,1)) / 2);
midy = ceil((size(C,2)) / 2);

% menghitung koordinat yang sesuai dari pixel A
% untuk setiap pixel C dan intensitasnya akan diberikan setelah diperiksa
for i = 1 : size(C,1)
    for j = 1 : size(C,2)                                                       
         x = (i - midx) * cos(rads) + (j - midy) * sin(rads);                                       
         y = -(i - midx) * sin(rads) +(j - midy) * cos(rads);                             
         x = round(x) + xo;
         y = round(y) + yo;
         if (x >= 1 && y >= 1 && x <= size(image,1) &&  y <= size(image,2)) 
              C(i,j,:) = image(x,y,:);  
         end
    end
end
image = C;
axes(handles.axes1); % memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); % memunculkan gambar


% --- Executes on button press in btn180.
function btn180_Callback(hObject, eventdata, handles)
% hObject    handle to btn180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[rowsi,colsi,z]= size(image); 

sudut = 180;
rads = 2 * pi * sudut / 360;  

% menghitung dimesi array agar gambar yang diputar akan sesuai dengan yg didalamnya
% menggunakan absolute agar bisa mendapatkan nilai positif 
rowsf = ceil(rowsi * abs(cos(rads)) + colsi * abs(sin(rads)));                      
colsf = ceil(rowsi * abs(sin(rads)) + colsi * abs(cos(rads)));                     

% menentukan array dengan parameter yang dihitung dan isi array dengan angka nol
C = uint8(zeros([rowsf colsf 3 ]));

% menghitung center of original and final image
xo = ceil(rowsi / 2);                                                            
yo = ceil(colsi / 2);

midx = ceil((size(C,1)) / 2);
midy = ceil((size(C,2)) / 2);

% menghitung koordinat yang sesuai dari pixel A
% untuk setiap pixel C dan intensitasnya akan diberikan setelah diperiksa
for i = 1 : size(C,1)
    for j = 1 : size(C,2)                                                       
         x = (i - midx) * cos(rads) + (j - midy) * sin(rads);                                       
         y = -(i - midx) * sin(rads) +(j - midy) * cos(rads);                             
         x = round(x) + xo;
         y = round(y) + yo;
         if (x >= 1 && y >= 1 && x <= size(image,1) &&  y <= size(image,2)) 
              C(i,j,:) = image(x,y,:);  
         end
    end
end
image = C;
axes(handles.axes1); % memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); % memunculkan gambar


% --- Executes on button press in btn270.
function btn270_Callback(hObject, eventdata, handles)
% hObject    handle to btn270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[rowsi,colsi,z]= size(image); 

sudut = 270;
rads = 2 * pi * sudut / 360;  

% menghitung dimesi array agar gambar yang diputar akan sesuai dengan yg didalamnya
% menggunakan absolute agar bisa mendapatkan nilai positif 
rowsf = ceil(rowsi * abs(cos(rads)) + colsi * abs(sin(rads)));                      
colsf = ceil(rowsi * abs(sin(rads)) + colsi * abs(cos(rads)));                     

% menentukan array dengan parameter yang dihitung dan isi array dengan angka nol
C = uint8(zeros([rowsf colsf 3 ]));

% menghitung center of original and final image
xo = ceil(rowsi / 2);                                                            
yo = ceil(colsi / 2);

midx = ceil((size(C,1)) / 2);
midy = ceil((size(C,2)) / 2);

% menghitung koordinat yang sesuai dari pixel A
% untuk setiap pixel C dan intensitasnya akan diberikan setelah diperiksa
for i = 1 : size(C,1)
    for j = 1 : size(C,2)                                                       
         x = (i - midx) * cos(rads) + (j - midy) * sin(rads);                                       
         y = -(i - midx) * sin(rads) +(j - midy) * cos(rads);                             
         x = round(x) + xo;
         y = round(y) + yo;
         if (x >= 1 && y >= 1 && x <= size(image,1) &&  y <= size(image,2)) 
              C(i,j,:) = image(x,y,:);  
         end
    end
end
image = C;
axes(handles.axes1); % memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); % memunculkan gambar