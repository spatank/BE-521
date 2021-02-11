%%
% <latex>
% \title{BE 521: Homework 3 Questions\\{\normalsize Feature extraction} \\{\normalsize Spring 2021}}
% \author{68 points}
% \date{Due: Tuesday, 2/16/2021 10pm}
% \maketitle
% \textbf{Objective:} Extract features from data and build a simple detector
% </latex>

%% 
% <latex>
% \begin{center}
% \author{NAME HERE \\
%   \normalsize Collaborators: COLLABORATORS HERE \\}
% \end{center}
% </latex>

%%
% <latex> 
% \section{Features and Simulations (39 pts)} As you learned
% in class, features are the backbone of almost all detection
% strategies, from seizures in EEG to faces in images. Features are
% usually defined in journal articles as an equation or set of
% equations, and the task for the reader---if she wants to use that
% feature---is to implement that feature in code. In this section, you
% will explore and implement some features commonly used in EEG
% analysis and test them on simulated time-series data.
% \begin{enumerate}
%  \item Consider the following toy signal: 7 seconds of a 2 Hz sine
%  wave with a quarter period phase-shift, sampled at 100 Hz
%   \begin{enumerate}
%    \item Plot the signal. (2 pts)
% </latex>

%%
% <latex>
% \item Using the Matlab functions for the difference, sum, and
%   absolute value of the elements in a vector (look them up if you
%   don't know them), create an anonymous function for the
%    line-length feature
% 	$ LL(\mathbf{x}) = \sum_{i=2}^{n} |x_i - x_{i-1}| $ in one line of
% 	Matlab code that uses no loops (i.e., the outputs of one function
% 	will be the inputs of another). Your function should look
% 	something like \begin{lstlisting}
% 	  LLFn = @(x) XXXXXX;
% 	\end{lstlisting}
% 	where \texttt{XXXXX} represents some use of the aformentioned functions and the input signal \texttt{x}. (4 pts)
%    \item What is the line length of this signal? (2 pts)
%   \end{enumerate}
% </latex>

%%
% <latex>
%  \item Consider line length of the signal using a sliding window
%  with a certain amount of window overlap (or, to think of it another
%  way, displacement with each ``slide''). Now, instead of having just
%  one value for the line length, you will have a number of values.
%   \begin{enumerate}
% 	\item Given a signal \texttt{x} with sampling frequency
% 	\texttt{fs} and windows of length \texttt{winLen} and displacement
% 	\texttt{winDisp} (both in seconds), create an anonymous function
% 	called \texttt{NumWins} that calculates the number of possible
% 	(full) windows in your signal of length \texttt{xLen} (in
% 	samples), i.e., \begin{lstlisting}
% 	  NumWins = @(xLen, fs, winLen, winDisp) XXXXXX;
% 	\end{lstlisting} where \texttt{XXXXXX} is the single-line
% 	expression for this value. You may assume that \texttt{winDisp} is
% 	a factor of both \texttt{winLen} (as it usually is/should be)
% 	and the length (in seconds) of \texttt{x}. (4 pts) 
% </latex>

%%
% <latex>
%   \item Use this
% 	function to calculate the number of windows for the signal
% 	described in Question 1.1 for a 400 ms window with 200 ms
% 	displacement, i.e., the expression \begin{lstlisting}
% 	  NumWins(length(x), fs, winLen, winDisp)
% 	\end{lstlisting} 
% 	where \texttt{fs}, \texttt{winLen}, and \texttt{winDisp} are the appropriate values. (1 pt)
% </latex>

%%
% <latex>
% 	\item Repeat the above calculation for 50 ms window displacement. (1 pt)
% </latex>

%%
% <latex>
% 	\item Repeat the above calculation for 100 ms window displacement. (1 pt)
%   \end{enumerate}
% </latex>

%%
% <latex> 
%   \item 
%   \begin{enumerate}
%    \item Create a function (in another file) called
%    \texttt{MovingWinFeats(x, fs, winLen, winDisp, featFn)} that
%    returns a vector of the values of the feature on the signal
%    \texttt{x} in all the possible windows, where \texttt{featFn} is
%    a feature function like the one you wrote in Question 1.1.b. You
%    may find it useful to use your \texttt{NumWins} function (or at
%    least its expression). You may assume that the product of
%    \texttt{winDisp} and the sampling rate \texttt{fs} is an integer.
%    (6 pts) \\
% </latex>

%%
% <latex>
% Make sure your MovingWinFeats code is in your pdf. One way is to use the following Matlab code (in your script) to automatically
% load in the function's code (where we assume that the function is
% one directory up from the *.tex file). Windows users may need to
% change the forward-slash to a backslash. 
% </latex>

%   <latex>
%   \lstinputlisting{[path to] MovingWinFeats.m}
%   </latex>

%%
% <latex>
%    \item Using the signal you defined in Question 1.1 and the function you created in Question 1.1.b, calculate the line-length over windows of length 400 ms and displacement 200 ms. (2 pts)
% </latex>

%%
% <latex>
%    \item Add a unit-amplitude 10 Hz signal (in the form of a sine wave) to your original signal and again calculate the line length over the same window and displacement. (2 pts)
%   \end{enumerate}
% </latex>

%%
% <latex>
%   \item Code the following 3 additional features in MINIMAL lines of code (hint: each can be implemented in one line using the anonymous function trick).
%   \begin{enumerate}
%    \item Area, $\displaystyle A(\mathbf{x}) = \sum_{i=1}^{n} |x_i| $ \quad (2 pts)
% </latex>

%%
% <latex>
%    \item Energy, $\displaystyle E(\mathbf{x}) = \sum_{i=1}^{n} x_i^2 $ \quad (2 pts)
% </latex>

%%
% <latex>
%    \item Zero-Crossings around mean,\\ $\displaystyle ZX(\mathbf{x}) = \sum_{i=2}^{n} \mathbf{1}(\mathbf{FromAbove}) \;\mbox{OR}\; \mathbf{1}(\mathbf{FromBelow})$, 
%        where $\mathbf{1}(\cdot)$ denotes the indicator function, which returns a zero if its argument is false and a one if it is true, 
%        $\mathbf{FromAbove}$ denotes $(x_{i-1} - \overline{x} > 0) \;\mbox{AND}\; (x_i - \overline{x} < 0)$, 
%        $\mathbf{FromBelow}$ denotes $(x_{i-1} - \overline{x} < 0) \;\mbox{AND}\; (x_i - \overline{x} > 0)$,
%        and $\overline{x}$ is the mean value of the elements in $x$. (4 pts)
% </latex>

%%
% <latex>
%    \item Plot the values of the four features on the combined signal in the first four cells of a 3x2 matlab subplot.
%    Use a 400 ms window with 100 ms displacement. Using the right-aligned convention (where the
%    ``official'' time of the feature is that of the last data point
%    in the window), give the appropriate time axis for each window
%    point. In addition, plot the original signal with the 2Hz and 10Hz
%    components in the last two cells of the 3x2 subplot (to make
%    comparing down the column easy). Ensure that the time axis in all
%    of your plots is the same. (6 pts)
% </latex>

%%
% <latex>
%   \end{enumerate}
% \end{enumerate}  
% \section{Feature Overlays (17 pts)}
% In this section, you will use a line-length feature overlay on a segment of EEG containing a seizure. This data is stored in \texttt{I521\_A0003\_D001} 
% \begin{enumerate}
%  \item What is the length using hours:minutes:seconds:milliseconds of the recording? (Use getDuration) (2 pts)
% </latex>

%%
% <latex>
%  \item How many data points should we discard at the end if we want to clip the recording to the last full second? Do this clipping. (1 pt)
% </latex>

%%
% <latex>
%  \item If we want to overlay a feature trace on the original signal, we have to interpolate that feature (which has been calculated over windows) for each data point of the original signal. One of the simplest methods of doing this is called zero-order interpolation, where we just hold the value constant until we get to the next calculated value. For example, if we had a moving window of 1 second with 1 second displacement, the zero-order interpolated feature vector would have the same value the entire first second, then the same for the entire second second, etc, where each second contains the same number of points as the sampling frequency of the original signal.
%  \begin{enumerate}
%   \item Using the \texttt{repmat} and \texttt{reshape} functions, create an external function \texttt{zoInterp(x, numInterp} that copies each value of \texttt{x} \texttt{numInterp} times. You can implement this function in one line of code with no loops. Include the code for this function as you did in Question 1.3.a. (2 pts)
% </latex>

%%
% <latex>
%   \item Confirm that this function works correctly by expanding the length of the vector \texttt{1:5} by a factor of 5 and plotting with the command
%   \begin{lstlisting}
% 	plot(zoInterp(1:5,5),'-o')
%   \end{lstlisting}
%   where the \texttt{'-o'} option lets us see the individul points as well as the line that connects them. (2 pts)
%  \end{enumerate}
% </latex>

%%
% <latex>
%  \item Using a 5-second sliding window with 1-second displacement,
%  calculate the line length feature over the entire signal. Normalize
%  the line-length feature values to have a maximum twice that of the
%  original EEG signal maximum. Plot the signal in blue and overlay
%  the right-aligned line-length feature in yellow. Note: you will need
%  to pad your
%  signal in order to get them to line up correctly and be the
%  same length. Put the units of your time axis in minutes, and be
%  sure to add a legend in a location in the plot that does not cover
%  up any signal or feature. (6 pts)
% </latex>

%%
% <latex>
%  \item What threshold might you use on the raw line-length feature
%  vector (not the normalized one used for plotting) in order to
%  capture the 17 largest pre-seizure chirps that occur? (1 pt)
% </latex>

%%
% <latex>
%  \item Using this threshold value, in another plot draw red vertical lines at the leading point in time where the threshold is crossed. Add these vertical lines on top of the plot you made in Question 2.4. These events should capture the pre-seizure chirps, the seizure onset, and some flickering during the end of the seizure. (3 pts)
% </latex>

%%
% <latex>
% \end{enumerate}
% \section{Building a Detector (12 pts)}
% In this section, you will use the features you defined previously to build a seizure detector. Use the EEG data in the file \texttt{I521\_A0003\_D002} with channels \texttt{multiSz\_1}, and \texttt{multiSz\_2}.
% \begin{enumerate}
%  \item Plot the signal in \texttt{multiSz\_1} and draw vertical red lines at the times when you think the two seizures begin. (You should be able to do this without the need of any features.) (2 pts)
% </latex>

%%
% <latex>
%  \item Produce feature overlay plots similar to that of Question 2.4 for each of the four features you have implemented along with the red vertical lines at each seizure. Use the same 4-second sliding window with 1 second displacement. (4 pts)
% </latex>

%%
% <latex>
%  \item 
%   \begin{enumerate}
%    \item Based on your plots in the previous question, which of the
%    four features seems to give the largest signal (relative to the
%    background) for when a seizure occurs? Explain why you think this feature is the best. (3 pts)
% </latex>

%%
% <latex>
%    \item What threshold would you use to determine if a seizure is occurring? (1 pt)
% </latex>

%%
% <latex>
%   \end{enumerate}
% </latex>

%%
% <latex>
%  \item The signal in \texttt{multiSz\_2} contains another seizure (whose location should again be fairly obvious). Plot the data along with the feature and threshold (horizontal black line, with correct normalization for the signal in \texttt{data2}) you determined in the previous question. (2 pts)
% </latex>

%%
% <latex>
% \end{enumerate}
% </latex>


