%[Arduino serial reader]
%   Version : 2022/2/20�CAuthor : Kazuki Ito
%   Arduino����o�͂����V���A�����P�s���ǂݎ��v���O����
%--------------------------------------------------------------------------

clear all
delete(instrfindall); 

port = "/dev/cu.usbserial-40110";  %Mac
%port = "COM6";                     %windows
baudrate = 115200; %�{�[���[�g       %Arduino�X�P�b�`����Serial.begin(baudrate)�Őݒ肵���{�[���[�g�ƈ�v������D

%serial setup
arduino = serial(port,'Baudrate',baudrate); %�V���A���̃N���X���`

fopen(arduino); %�V���A���I�[�v��

%�V���A���f�[�^���i�[����ϐ�
serial_cap=[];

%�擾����V���A���Ɋւ��鏈��
%sArduino����o�͂����V���A���P�s���f�[�^�`���ō\������Ă��邩�̃t�H�[�}�b�g���w�聫
% �� : '%d' : int�^�C'%f : float�^'
% �ڂ�����>https://jp.mathworks.com/help/matlab/matlab_prog/formatting-strings.html
formatSpec = '%f,%d,%f';

%�V���A����s�̗�(�J���}��؂�)
data_row   = 3;

%�����I���pfigure
hf=figure('position',[0 0 eps eps],'menubar','none');
% hf.title("Reading serial data")

disp("Serial data recording start. If you want stop recording, please push [q] key.")

%�V���A���f�[�^�̎擾�����v�Z�p�^�C�}�[
start_t = tic;

while 1
    serial_cap = [serial_cap; fscanf(arduino, formatSpec, [1 data_row])];
    
    %"q"�ŏI��
    if strcmp(get(hf,'currentcharacter'),'q')
        close(hf)
        end_t = toc(start_t);
        break
    end
    figure(hf)
    drawnow
end

%�V���A�������
fclose(arduino);
delete(instrfindall);
close(hf);

fprintf(sprintf("Serial sent cycle : %f[Hz]\n",length(serial_cap(:,1))/end_t))
disp("Quit Serial reader, close serial port.")






    
 