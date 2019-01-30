%% Jeffrey J. Walker
%% CPP 782

%% walker_relax_frontend.m is a front end for the walker_relax.m function, which
%% performs successive overrelaxation for a square grid with boundaries specified.
%% 
%% Enter Matlab, open this m file, press f5 and answer the prompts.
clear all;

disp('walker_relax_frontend.m is a script which will perform successive overrelaxation')
disp('I advise making a brief sketch of your surfaces to see how they fit inside the computational volume.')

%% get the physical size of the box in meters
L=input('Size of the square box? (in meters)?','s');
L=str2num(L);

if length(L)~=1||L<0;
    exception='You must use a positive definite value for the length!';
    error(exception);
end

%% number of computational cells:
n=input('Number of computational cells in the 2D matrix (n>=10)?','s');
n=str2num(n);n=uint8(n);
if length(n)~=1||n<10||isa(n,'uint8')~=1;
    exception='You must use an integer value (n>10) for the number of cells!';
    error(exception);
end
ds=L/double(n);

%% now set up coordinate system.
x=linspace(0,L,n);
y=linspace(0,L,n);
V=zeros(n);
%% mask matrix, which is used to preserve bcs inside the computational volume.
%% this will be updated later, but for now just initializing it so that it's 
%% the same size as V.
mask=V;

%% get V1, the voltage set on the x=0 line of the box
V1=input('Voltage on x=0 line of box?','s');
V1=str2num(V1);
if length(V1)~=1||isa(V1,'double')~=1;
    exception='You must have not typed in a number.';
    error(exception);
end
%% the x=0 bc:
V(1,1:n)=V1;

%% get V2, the voltage set on the y=0 line
V2=input('Voltage on y=0 line of box?','s');
V2=str2num(V2);
if length(V2)~=1||isa(V2,'double')~=1;
    exception='You must have not typed in a number.';
    error(exception);
end
%% the y=0 bc:
V(1:n,1)=V2;

%% get V3, the voltage set on the x=L line
V3=input('Voltage on x=L line of box?','s');
V3=str2num(V3);
if length(V3)~=1||isa(V3,'double')~=1;
    exception='You must have not typed in a number.';
    error(exception);
end
%% the x=L bc:
V(n,1:n)=V3;

%% get V3, the voltage set on the y=L line
V4=input('Voltage on y=L line of box?','s');
V4=str2num(V4);
if length(V4)~=1||isa(V4,'double')~=1;
    exception='You must have not typed in a number.';
    error(exception);
end
%% the y=L bc:
V(1:n,n)=V4;
%% update mask briefly here (although this is not strictly necessary)
mask=V;

%% This block prompts user for rectangles placed into the volume
n_rect=input('How many *filled* rectangles do you want inside the computational Volume?','s');
n_rect=str2num(n_rect);n_rect=uint8(n_rect);
if length(n_rect)~=1||n_rect<0||isa(n_rect,'uint8')~=1;
    exception='You must use an integer value (n_rect>=0) for the number of rectangles!';
    error(exception);
end

for counter=1:n_rect
    V_rect=input('Voltage for this filled rectangle?','s');
    V_rect=str2num(V_rect);
    x_cent=input('x position for center of this rectangle?','s');
    x_cent=str2num(x_cent);x_cent=round(x_cent/ds);
    y_cent=input('y position for center of this rectangle?','s');
    y_cent=str2num(y_cent);y_cent=round(y_cent/ds);
    l_rect=input('length (x-distance) of this rectangle?','s');
    l_rect=str2num(l_rect);l_rect=round(l_rect/ds);
    h_rect=input('height (y-distance) of this rectangle?','s');
    h_rect=str2num(h_rect);h_rect=round(h_rect/ds);
    x_coords=[round(x_cent-l_rect/2):round(x_cent+l_rect/2)];
    y_coords=[round(y_cent-h_rect/2):round(y_cent+h_rect/2)];
    V(x_coords,y_coords)=V_rect;
    %% make sure that these bc's are implemented correctly, and if the voltage
    %% is zero on the surface, then it should still not be updated.
    if V_rect==0;
        mask(x_coords,y_coords)=1;
    else
        mask=V;
    end
    
end

%% This block prompts user for circles placed into the volume
n_circ=input('How many *filled* cirlces do you want inside the computational Volume?','s');
n_circ=str2num(n_circ);

for counter=1:n_circ
    V_circ=input('Voltage for this filled circle?','s');
    V_circ=str2num(V_circ);
    x_cent=input('x position for center of this circle?','s');
    x_cent=str2num(x_cent);x_cent=round(x_cent/ds);
    y_cent=input('y position for center of this circle?','s');
    y_cent=str2num(y_cent);y_cent=round(y_cent/ds);
    radius=input('radius for this circle?','s');
    radius=str2num(radius);%radius=round(radius/ds);
    x_coords=[round(x_cent-radius/ds):round(x_cent+radius/ds)];
    x_circ=ds*x_coords;
    y_circ_plus=ds*y_cent+sqrt(radius^2-(x_circ-ds*x_cent).^2);
    y_circ_minus=ds*y_cent-sqrt(radius^2-(x_circ-ds*x_cent).^2);
    y_coords=round(y_circ_plus/ds);
    [irrelevant,x_size]=size(x_coords);
    %% approximate a circle in the square gridding, making sure to hold the
    %% potential at a fixed voltage even if V=0.
    for index=1:x_size
        V(x_coords(index),y_cent-(y_coords(index)-y_cent):y_cent+(y_coords(index)-y_cent))=V_circ;
        if V_circ==0;
            mask(x_coords(index),y_cent-(y_coords(index)-y_cent):y_cent+(y_coords(index)-y_cent))=1;
        else
            mask(x_coords(index),y_cent-(y_coords(index)-y_cent):y_cent+(y_coords(index)-y_cent))=V_circ;
        end
    end
end

n_wire=input('How many wires do you want inside the computational Volume?','s');
n_wire=str2num(n_wire);

for counter=1:n_wire
    V_wire=input('Voltage for this wire?','s');
    V_wire=str2num(V_wire);
    x_start=input('x starting position of wire?','s');
    x_start=str2num(x_start);
    x_finish=input('x final position of wire?','s');
    x_finish=str2num(x_finish);
    y_start=input('y starting position of wire?','s');
    y_start=str2num(y_start);
    y_finish=input('y final position of wire?','s');
    y_finish=str2num(y_finish);
    run=round((x_finish-x_start)/ds);
    rise=round((y_finish-y_start)/ds);
    x_coords=[x_start/ds:run];
    
    
    %% sketch a wire in the coordinate space
    for index=1:length(x_coords)
        y_coords(index)=round((rise/run)*index)+round(y_start/ds);
        %% make sure the bcs are handled properly.
        if V_wire==0;
            mask(x_coords(index),y_coords(index))=1;
            V(x_coords(index),y_coords(index))=V_wire;
        else
            V(x_coords(index),y_coords(index))=V_wire;
            mask(x_coords(index),y_coords(index))=V_wire;
        end
        
    end
       
end




%% show a little plot for what the starting grid in voltage looks like
h=surf(x,y,V);set(gca,'fontsize',16);colormap(jet);xlabel('x-coord');ylabel('y-coord')

goahead=input('Does this look right? (y/n)','s');
if goahead=='y'
    %% Everything is set up, now ready to run the overrelaxation algorithm.
    %% user-input for the tolerance desired
    update_limit=input('When do you want to stop the relaxation \n (When the Voltage update is less than this value, program will terminate)?','s');
    update_limit=str2num(update_limit);

    %% relaxation parameter
    w=input('Value for the relaxation parameter? (1.5 is recommended)?','s');
    w=str2num(w);
    h=0;
    [x,y,V]= walker_relax(x,y,V,mask,update_limit,w);
else
    [V]=0;
    disp('Rerun the program and try again if you have made an error.')
end

% savefile=input('Would you like to save your data in ascii format (y/n)?');
% if savefile=='y'
%    save    
% end
