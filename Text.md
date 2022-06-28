# How much do we believe in students who say they have used drugs?

[Francisco Cardozo](https://github.com/focardozom), [Pablo Montero-Zamora](https://scholar.google.es/citations?user=jw7I6NUAAAAJ&hl=en)


Confidence in students' survey responses is commonly questioned when performing drug use research. For example, one's can wonder 
**how do you know students are telling the truth about their alcohol consumption?** We recognize this as a legitimate question that can be even more complex when considering two types of students: 1) those who say they have not used alcohol but used it (i.e., deniers); and 2) those who say they have used it but actually never use it (i.e., braggers). 
It is crucial to understand how this reporting bias affects the validity of our measurements and research findings. Therefore, we propose the following app to understand how proportions of deniers, braggers, and drug use prevalence can influence confidence levels in self-reported measures collected in adolescents. 


* **True prevalence:** number of students using a drug divided by the entire population.  
* **Deniers:** students who say they have not used a drug but used it. 
* **Braggers:**students who say they have used a drug but actually never use it. 

Given the information above, we can estimate the probability of a student's drug use behavior if they respond Yes or No to a drug use question. 
 
To model this probability, we can use the **Bayes theorem:**

\begin{equation}
\label{eq:bayesa}
P(A | B) = P(A) \frac{P(B | A)}{P(B)}
\end{equation}

Replace our variables of interest:

* **P(A|B)** = Drug use given they say yes in the questionnaire.
* **P(B|A)** = Say yes given that they have used drugs.
* **P(A)** = Drug use prevalence.
* **P(B)** = Say yes in the questionnaire.

Ahead are two different simulated scenarios to understand how the trust in student responses changes. Follow the two scenarios to see two extreme cases, and then play with the number of deniers and braggers in your study population. 





