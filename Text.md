# How much do we believe in students who say they have used drugs?

After presenting research on alcohol use in adolescents, I am always asked about my confidence in the students' survey responses. **How do you know the students are being honest?** is a legitimate question for some people because they believe that most students lie, saying they have not used alcohol (deniers). In contrast, others argue the liars say they have used it (braggers). Of course, there are multiple ways to control the liars (i.e., using a fake drug, granting anonymity, checking for consistency, etc.) But, in this app, we want to simulate the confidence in students' responses to a drug survey based on three different components:  the true prevalence of drug use, the proportion of deniers, and the proportion of braggers. 

* **The true prevalence** of drug use is how many students are actually using the drug. 
* **Deniers** are students who have used drugs but say they haven't used it.  
**Braggers** are students who haven't used drugs but say they have used it. 

Whit this information can estimate the probability of a student using a drug given that they say Yes/No in the questionnaire. 

We only need to use the **Bayes theorem:**

\begin{equation}
\label{eq:bayesa}
P(A | B) = P(A) \frac{P(B | A)}{P(B)}
\end{equation}

Replace our variables of interest:

* **P(A|B)** = Drug use given they say yes in the questionnaire 
* **P(B|A)** = Say yes given that they have used drugs. 
* **P(A)** = Drug use prevalence
* **P(B)** = Say yes in the questionnaire





