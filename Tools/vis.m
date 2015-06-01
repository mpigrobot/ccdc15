function vis(data, truth, step, visualize)
    if visualize == 0
        return;
    end
    %%
    rob  =[0 -2 -2;0 1 -1];%The size of robot
    xFilter = data.path;
    pos     = data.pos;
    xTrue   = truth.x;
    %% Initial figure.
    figure('name','SLAM Demo','color','w','units','normalized',...
         'outerposition',[0 0 1 1]);
    hold on; box on;
    xlabel('x(m)');
    ylabel('y(m)');
    axis equal;
    xlim([-50,20]);
    ylim([-30,30]);  
    %% Plot landmarks and waypoints.
    trueRob = patch('Faces',[1,2], 'linewidth',1,'markeredgecolor','r',...
    'facecolor','y','erasemode', 'normal');
    filterRob = patch('Faces',[1,2], 'linewidth',1,'markeredgecolor','k',...
    'facecolor','c','erasemode', 'normal');
    truePath    = plot(0,0,'g-','linewidth',1.5,'erasemode','normal');
    filterPath  = plot(0,0,'b','linewidth',1.5,'erasemode','normal');
    obsFeature  = plot(0,0,'m.','linewidth',1,'erasemode','normal');
    %% For legend.
    trueRob_     = plot(100,100,'<','markersize',10,'markeredgecolor','r',...
                        'markerfacecolor','y','linewidth',1);
    filterRob_   = plot(100,100,'<','markersize',10,'markeredgecolor','k',...
                        'markerfacecolor','c','linewidth',1);
    hC          = [trueRob_,filterRob_,truePath,filterPath,obsFeature];
    lgdErob  = 'Particle filter Robot';
    lgdEpth  = 'Particle filter Path';
    lgd = legend(hC,lgdErob,'True Robot',lgdEpth,'True Path','Observations');
    set(lgd ,'box','off','fontsize',10,'textcolor',[92,194,216]/255,...
  'location', 'north','orientation','horizontal','FontWeight','bold'); 
    %% Animation
    %%
    for k = 1:step
        trueRobBody   = compound(xTrue(1:3,k), rob);
        filterRobBody = compound( xFilter(:,k), rob);
        %% 
        set(trueRob,  'xdata', trueRobBody(1,:), ...
            'ydata', trueRobBody(2, :));
        set(filterRob,  'xdata', filterRobBody(1,:), ...
            'ydata', filterRobBody(2, :));
        set(truePath,  'xdata', xTrue(1,1:k), ...
            'ydata', xTrue(2,1:k));
        set(filterPath,  'xdata', xFilter(1,1:k), ...
            'ydata', xFilter(2,1:k));

        %% Observed features
         if ~isempty(pos(k).x)
             set(obsFeature, 'xdata', pos(k).x(1,:), 'ydata',pos(k).x(2,:));
         end

        drawnow;
        
    end
