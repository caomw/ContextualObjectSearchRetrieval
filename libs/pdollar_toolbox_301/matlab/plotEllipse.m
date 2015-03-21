function [h,hc,hl] = plotEllipse(cRow,cCol,ra,rb,phi,color,nPnts,lw,lf,ls)
% Adds an ellipse to the current plot.
%
% USAGE
%  [h,hc,hl] = plotEllipse(cRow,cCol,ra,rb,phi,[color],[nPnts],[lw],[ls])
%
% INPUTS
%  cRow    - the row location of the center of the ellipse
%  cCol    - the column location of the center of the ellipse
%  ra      - semi-major axis radius length (in pixels) of the ellipse
%  rb      - semi-minor axis radius length (in pixels) of the ellipse
%  phi     - rotation angle (radians) of semimajor axis from x-axis
%  color   - ['b'] color for ellipse
%  nPnts   - [100] number of points used to draw each ellipse
%  lw      - [1] line width
%  lf      - Line fill
%  ls      - ['-'] line style
%
% OUTPUT
%  h       - handle to ellipse
%  hc      - handle to ellipse center
%  hl      - handle to ellipse orient
%
% EXAMPLE
%  plotEllipse( 3, 2, 1, 5, pi/6, 'g');
%
% See also plotGaussEllipses
%
% Piotr's Image&Video Toolbox      Version 2.42
% Copyright 2012 Piotr Dollar.  [pdollar-at-caltech.edu]
% Please email me if you find bugs, or have suggestions or questions!
% Licensed under the Simplified BSD License [see external/bsd.txt]

error(nargchk( 5, 10, nargin ));
if(nargin<6 || isempty(color)); color = 'b'; end
if(nargin<7 || isempty(nPnts)); nPnts = 100; end
if(nargin<8 || isempty(nPnts)); lw = 1; end
if(nargin<9 || isempty(ls)); lf = 0; end
if(nargin<10 || isempty(ls)); ls = '-'; end


% plot ellipse (rotate a scaled circle):
ts = linspace(-pi,pi,nPnts+1);  cts = cos(ts); sts = sin(ts);
X = ra*cts*cos(-phi) + rb*sts*sin(-phi) + cCol;
Y = rb*sts*cos(-phi) - ra*cts*sin(-phi) + cRow;
h = plot(X, Y);

% plot center point and line indicating orientation
washeld = ishold; if(~washeld); hold('on'); end
hc = plot( cCol, cRow, 'k+' );
hl = plot( [cCol cCol+cos(-phi)*ra], [cRow cRow-sin(-phi)*ra] );

set([h hc hl],'Color',color,'LineWidth',lw,'LineStyle',ls);

if lf
    fill(X,Y,color);
end

if(~washeld); hold('off'); end;

end
