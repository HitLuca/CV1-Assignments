function [ A, t, final_inliers ] = ransac( iterations, matches, f1, f2, number_match  )
    final_inliers = 0;
    for k = 1:iterations
        perm = randperm(size(matches,2)) ; % random sampling from the matches
        m_ind = perm(1:number_match) ;     % index for the matches

        im1_ind = matches(1, m_ind);       % index for matched descriptors in image 1
        im2_ind = matches(2, m_ind);       % index for matched descriptors in image 2

        im1_matches = f1(1:2, im1_ind);
        im2_matches = f2(1:2, im2_ind);

        % construct A, and b, then find x
        A = zeros(number_match*2, 6);
        B = zeros(number_match*2, 1);

        j = 1;
        for i = 1:number_match
            tmpA = [im1_matches(:, i)', 0, 0, 1, 0; 0, 0, im1_matches(:, i)', 0, 1];
            tmpB = im2_matches(:, i)';
            A(j:j+1, :) = tmpA;
            B(j:j+1, :) = tmpB;
            j = j + 2;
        end

        x = pinv(A)*B; % transformation parameters

        % Check Inliers (still in RANSAC iterations), transform
        im1_all = f1(1:2, matches(1, :)); % x, y location for all the matched points
        im2_all = f2(1:2, matches(2, :));

        % transform im1_all according to the transformation parameters
        A = reshape(x(1:4), 2, 2)';
        t = x(5:6);
        im1_t = A * im1_all + t;

        % count inliers
        % Calculate the distance beteen the pairs
        tmp = abs(im2_all - im1_t);
        dist = sqrt(sum(tmp.^2, 1));

        inliers = sum(dist < 10);

        if inliers > final_inliers
            final_inliers = inliers;
            param_t = x;
        end
    end
    A = reshape(param_t(1:4), 2, 2)';
    t = param_t(5:6);
end

