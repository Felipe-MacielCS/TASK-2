%% Script mainScript2 to run runTwoSeriesLinkSim() Function.
%
% Parameters:
% Ks - array for the number of packets (K)
% N - the number of simulations for each K
% p_vals - array of probabilities of failure for each transmission
% colors - array of colors for plot in K values
%
% Output: 
% Plots (Graphs) showing the calculated and simulated number of transmissions for different values of K and p
% - Individual plots for each K
% - Combined plot for all K values
%

Ks = [1, 5, 15, 50, 100];

% Number of simulations
N = 1000;

% Range of probability of failure (p)
p_vals = linspace(0.01, 0.99, 50); % simulate across 50 values of p between 0.01 and 0.99

% Preallocate space for results
calculatedResults = zeros(length(Ks), length(p_vals));
simulatedResults = zeros(length(Ks), length(p_vals));

% Loop over each value of K
for kIdx = 1:length(Ks)
    K = Ks(kIdx);

    % Loop over each value of p
    for pIdx = 1:length(p_vals)
        p = p_vals(pIdx);

        % Simulated result using the function runTwoSeriesLinkSim()
        simulatedResults(kIdx, pIdx) = runTwoSeriesLinkSim(K, p, N);

        % Calculated result (since two series links require doubling the expected value of single link)
        calculatedResults(kIdx, pIdx) = K * (1/(1 - p)) * 2; % Expected result is doubled for two series links
    end

    % Plot results for each K
    figure;
    hold on;
    plot(p_vals, calculatedResults(kIdx, :), 'LineWidth', 2, 'DisplayName', 'Calculated');
    plot(p_vals, simulatedResults(kIdx, :), 'ro', 'MarkerSize', 5, 'DisplayName', 'Simulated');
    hold off;
    
    % Add labels and title
    xlabel('Probability of Failure (p)');
    ylabel('Average Number of Transmissions');
    title(['Two Series Link Network - K = ', num2str(K)]);
    legend show;
    set(gca, 'YScale', 'log'); % Logarithmic scale for Y-axis for readability

    % Save figure (optional)
    saveas(gcf, ['TwoSeriesLink_K_', num2str(K), '.png']);
end

% Combined plot for all K values
figure;
hold on;
colors = {'b', 'g', 'r', 'c', 'm'}; % Different colors for each K

for kIdx = 1:length(Ks)
    K = Ks(kIdx);
    plot(p_vals, calculatedResults(kIdx, :), 'LineWidth', 2, 'Color', colors{kIdx}, 'DisplayName', ['Calculated K = ', num2str(K)]);
    plot(p_vals, simulatedResults(kIdx, :), 'o', 'MarkerSize', 5, 'Color', colors{kIdx}, 'DisplayName', ['Simulated K = ', num2str(K)]);
end

hold off;
xlabel('Probability of Failure (p)');
ylabel('Average Number of Transmissions');
title('Two Series Link Network - All K Values');
legend show;
set(gca, 'YScale', 'log'); % Logarithmic scale for Y-axis

