% Hexagon Lattice of ice and water
%% Set Gamma and Beta here!
    Gamma = 0.83;
    Beta = 0.193;
%%  Config the size of matrix
    l=20; %define a l by b matrix
    b=20;
%%  Number of steps(dont enter something crazy)
    times = 6;
%%  No need to change this part
    C=rand(l,b);
    xhex=[0 1 2 2 1 0]; % x-coordinates of the vertices
    yhex=[2 3 2 1 0 1]; % y-coordinates of the vertices   
  
    
    hex_matrix=ones(l,b)*Beta;%a matrix of all zeros to start with
    
    hex_matrix(l/2,b/2)=1;%set up the center to be the initial ice
    
    
    f = figure('Name','Let it go');
    drawnow

%% make an empty matrix first
    for t=1:b
        
     for i=1:b    %using a for loop to draw a hexagon for the ith 1 to 10 row
        j=i-1;    %for j-th column
        for k=1:l   
            m=k-1;
             %choose the color as black to indicate ice
           
            patch((xhex+mod(k,2))+2*j,yhex+2*m,'w')%make a hexagon at [2i,2j]  
            
      
              
        end
     end
    drawnow;
    axis equal  
  
    end
    
    makeIce(hex_matrix)
    generating(hex_matrix,times,Gamma)
    %patch(xhex+l-2,yhex+b,'b');
    
%% Plot colored hex on given postion based on l and b
    function makeIce(positions)
        xhex=[0 1 2 2 1 0];
        yhex=[2 3 2 1 0 1];
        [m,n] = size(positions);
        
     for i=2:m-1    %using a for loop to draw a hexagon for the ith 1 to 10 row
         %for j-th column
        for k=2:n-1  
            if positions(i,k)>=4 
                
                if mod(i,2) ==1 && mod(k,2)==1
                    
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.117,0.16,1])
                elseif mod(i,2) ==0 && mod(k,2)==1
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.117,0.16,1])
                else
                    patch(xhex+2*(i-1),yhex+2*(k-1),[0.117,0.16,1])
                    
                end
            elseif positions(i,k)>=1  && positions(i,k)<4 
                
                if mod(i,2) ==1 && mod(k,2)==1
                    
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.117,0.56,1])
                elseif mod(i,2) ==0 && mod(k,2)==1
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.117,0.56,1])
                else
                    patch(xhex+2*(i-1),yhex+2*(k-1),[0.117,0.56,1])
                    
                end
            elseif positions(i,k)>=0.6 && positions(i,k)<1
                if mod(i,2) ==1 && mod(k,2)==1
                    
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.529,0.801,0.98])
                elseif mod(i,2) ==0 && mod(k,2)==1
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.529,0.801,0.98])
                else
                    patch(xhex+2*(i-1),yhex+2*(k-1),[0.529,0.801,0.98])
                    
                end
            elseif positions(i,k)<0.6 && positions(i,k)>=0.3
                if mod(i,2) ==1 && mod(k,2)==1
                    
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.729,0.98,0.98])
                elseif mod(i,2) ==0 && mod(k,2)==1
                    patch(xhex+2*(i-0.5),yhex+2*(k-1),[0.729,0.98,0.98])
                else
                    patch(xhex+2*(i-1),yhex+2*(k-1),[0.729,0.98,0.98])
                end

            end
            
        end
     end
    drawnow;
    axis equal  
  % rgb(176,224,230) 
   %	 rgb(135,206,250)
   %rgb(30,144,255)
    end 
    
    %%
    function b = is_receptive(matrix,i,j)
    [m,n] = size(matrix);
    if i~=1 && j~=1 && i~=m && j~=n
        if mod(j,2)== 1
            if (matrix(i+1,j-1)>=1) || (matrix(i,j+1)>=1) || (matrix(i+1,j)>=1) ||(matrix(i,j-1)>=1) || (matrix(i-1,j)>=1) || (matrix(i+1,j+1)>=1) || (matrix(i,j)>=1)
                b = true;
            else
                b = false;
            end
        else
            if (matrix(i-1,j-1)>=1) || (matrix(i,j+1)>=1) || (matrix(i+1,j)>=1) ||(matrix(i,j-1)>=1) || (matrix(i-1,j)>=1) || (matrix(i-1,j+1)>=1) || (matrix(i,j)>=1)
                b = true;
            else
                b = false;
            end
        end
    else
        b = false;
    end
    end
    %%
    function surronding = sum_neighbour(matrix,i,j)
    [m,n] = size(matrix);
    if i~=1 && j~=1 && i~=m && j~=n
        if mod(j,2)== 1
            surronding = matrix(i+1,j-1)+matrix(i,j+1)+matrix(i+1,j)+matrix(i,j-1)+matrix(i-1,j)+matrix(i+1,j+1);
        else
            surronding = matrix(i-1,j-1)+matrix(i,j+1)+matrix(i+1,j)+matrix(i,j-1)+matrix(i-1,j)+matrix(i-1,j+1);
        end
    else
        surronding = 0;
    end
    end   
    
    %%
    function generating(matrix,times,Gamma)
        [m,n] = size(matrix);
        %changed_list = repmat(matrix,1);
        receptive = zeros(size(matrix));
        
        non_receptive = zeros(size(matrix));
        
        
        
        if times > 0 
            for i=2:m-1 
                for j=2:n-1
                    if i~=1 && j~=1 && i~=m && j~=n
                        %if mod(j,2)== 1
                         %   surronding = matrix(i+1,j-1)+matrix(i,j+1)+matrix(i+1,j)+matrix(i,j-1)+matrix(i-1,j)+matrix(i+1,j+1);
                        %else
                         %   surronding = matrix(i-1,j-1)+matrix(i,j+1)+matrix(i+1,j)+matrix(i,j-1)+matrix(i-1,j)+matrix(i-1,j+1);
                        %end
                        %if surronding == 1
                         %   changed_list(i,j)=1;
                        %end
                        if is_receptive(matrix,i,j)
                            receptive(i,j) = matrix(i,j)+Gamma;
                        else
                            non_receptive(i,j) = matrix(i,j);
                        end
                    end
                end
            end
        
            copy_nonrecp = repmat(non_receptive,1);
            
            for i=2:m-1
                for j=2:n-1
                    if non_receptive(i,j)~=0
                        copy_nonrecp(i,j) = 0.5*non_receptive(i,j)+ sum_neighbour(non_receptive,i,j)/12;
                    end
                end
            end
            
            
            %for i=1:m 
                %for j=1:n
                %    if changed_list(i,j)==1
               %         matrix(i,j)=1;
              %      end
             %   end
            %end
        
           m = copy_nonrecp + receptive ;
           
           makeIce(m)
           generating(m,times-1,Gamma)
           
           
        else
            matrix
        end
    end
    %%
    
