function plotVFraction( vFraction )
%PLOTVFRACTION plots Void Fraction over time
%   Detailed explanation goes here

numPlots = length(vFraction{1});
elements = length(vFraction);
time = 1:elements;

figure();
for i = 1:numPlots
    subplot(numPlots,1,i)
    hold on
    for j = 1:elements
        y(j)= vFraction{j}(i);
    end
    plot(time,y);
    hold off
end

figure
for k = 1:elements
   summ(k) = sum(vFraction{k}(:)); 
end
plot(time,summ)

end

