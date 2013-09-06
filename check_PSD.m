function check_PSD( M )

[~, D] = eig(M);
s = sort(diag(D), 'descend');

if s(end)>0
    fprintf('Matrix is PSD, min EV : %1.4e\n', s(end));
else
    warning('MATLAB:paramAmbiguous','Matrix is not PSD, min EV : %1.4e', s(end));
end

end

