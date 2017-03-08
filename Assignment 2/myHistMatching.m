function imOut = myHistMatching ( input , reference )
% number of chosen bins for the histograms
bins = 255;

% count the pixels at each intensity, creating an histogram
[input_hist, ~] = histcounts(input, bins);
[ref_hist, ~] = histcounts(reference, bins);

subplot(1, 2, 1);
imshow(input);
title('Original');
subplot(1, 2, 2);
bar(input_hist);
title('Histogram');

figure();
subplot(1, 2, 1);
imshow(reference);
title('Reference');
subplot(1, 2, 2);
bar(ref_hist);
title('Histogram');

% vector in which the assignments are stored
lookup_table = zeros(bins, 1, 'uint8');

% calculate normalized CDF for both input and reference
input_cdf = calculateCdf(input_hist);
reference_cdf = calculateCdf(ref_hist);

% find the index of the bin in the reference image that is closest to the one in input image
for i = 1 : bins
    [minimum, j] = min(abs(input_cdf(i) - reference_cdf)); %[min, argmin] of the array
    lookup_table(i) = j;
end

% shift the bins so that the CDF is close to the reference image
imOut = lookup_table(double(input));

[result_hist, ~] = histcounts(imOut, 255); 
cdf3 = calculateCdf(result_hist);

figure()
subplot(1, 2, 1);
imshow(imOut);
title('Matched');
subplot(1, 2, 2);
bar(result_hist);
title('Histogram');

% uncomment to show the cumulative distribution functions
% figure()
% subplot(1, 3, 1);
% bar(input_cdf);
% subplot(1, 3, 2);
% bar(reference_cdf);
% subplot(1, 3, 3);
% bar(cdf3);
end

function [cdf] = calculateCdf(histogram)
    % n used to normalize the distributions to 1
    n = sum(histogram);
    
    cdf = zeros(size(histogram));
    
    cdf(1) = histogram(1) / n;
    for i=2:numel(histogram)
        cdf(i) = cdf(i-1) + histogram(i) / n;
    end
end
