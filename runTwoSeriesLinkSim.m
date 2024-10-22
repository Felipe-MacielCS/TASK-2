%% Function runTwoSeriesLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure for each link
% N - the number of simulations to run
%
% Returns: the average number of transmissions required across the two series link network

function result = runTwoSeriesLinkSim(K, p, N)
    simResults = ones(1, N); % Store results for each simulation

    for i = 1:N
        txAttemptCount = 0; % total number of transmission attempts
        pktSuccessCount = 0; % number of packets that successfully made it through both links

        while pktSuccessCount < K
            r1 = rand; % Random value for Link 1
            r2 = rand; % Random value for Link 2
            txAttemptCount = txAttemptCount + 1; % Count initial transmission attempt

            % Keep transmitting until both links succeed (r1 > p and r2 > p)
            while r1 < p || r2 < p
                r1 = rand; % Recalculate random value for Link 1
                r2 = rand; % Recalculate random value for Link 2
                txAttemptCount = txAttemptCount + 1; % Count another transmission attempt
            end

            pktSuccessCount = pktSuccessCount + 1; % Packet successfully transmitted across both links
        end

        simResults(i) = txAttemptCount; % Store the total number of attempts for this simulation
    end

    result = mean(simResults); % Return the average number of transmissions over N simulations
end
