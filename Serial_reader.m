%[Arduino serial reader]
%   Version : 2022/2/20，Author : Kazuki Ito
%   Arduinoから出力されるシリアルを１行ずつ読み取るプログラム
%--------------------------------------------------------------------------

clear all
delete(instrfindall); 

port = "/dev/cu.usbserial-40110";  %Mac
%port = "COM6";                     %windows
baudrate = 115200; %ボーレート       %Arduinoスケッチ内のSerial.begin(baudrate)で設定したボーレートと一致させる．

%serial setup
arduino = serial(port,'Baudrate',baudrate); %シリアルのクラスを定義

fopen(arduino); %シリアルオープン

%シリアルデータを格納する変数
serial_cap=[];

%取得するシリアルに関する処理
%sArduinoから出力されるシリアル１行がデータ形式で構成されているかのフォーマットを指定↓
% 例 : '%d' : int型，'%f : float型'
% 詳しくは>https://jp.mathworks.com/help/matlab/matlab_prog/formatting-strings.html
formatSpec = '%f,%d,%f';

%シリアル一行の列数(カンマ区切り)
data_row   = 3;

%実験終了用figure
hf=figure('position',[0 0 eps eps],'menubar','none');
% hf.title("Reading serial data")

disp("Serial data recording start. If you want stop recording, please push [q] key.")

%シリアルデータの取得周期計算用タイマー
start_t = tic;

while 1
    serial_cap = [serial_cap; fscanf(arduino, formatSpec, [1 data_row])];
    
    %"q"で終了
    if strcmp(get(hf,'currentcharacter'),'q')
        close(hf)
        end_t = toc(start_t);
        break
    end
    figure(hf)
    drawnow
end

%シリアルを閉じる
fclose(arduino);
delete(instrfindall);
close(hf);

fprintf(sprintf("Serial sent cycle : %f[Hz]\n",length(serial_cap(:,1))/end_t))
disp("Quit Serial reader, close serial port.")






    
 