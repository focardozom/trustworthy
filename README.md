# What is the level of trust we have in a student's response when asked about drug consumption?

[Francisco Cardozo](https://github.com/focardozom), [Pablo Montero-Zamora](https://scholar.google.es/citations?user=jw7I6NUAAAAJ&hl=en)

Confidence in students' survey responses is often called into question when researching drug use, as it can be difficult to determine whether students are being truthful about their alcohol consumption and other drug use. We recognize that this is a valid concern, as the accuracy of self-reported drug use data can be affected by various types of reporting biases. For example, some students may underreport their drug use (i.e., deniers), while others may overreport their use (i.e., braggers). It is important to understand how these biases can impact the validity of research findings, and to take steps to minimize their influence.

As a tool to address the issue of reporting bias in research on drug use in adolescents, we propose a simulation-based app that can help to analyze the potential effects of deniers and braggers at different prevalence levels. This app could be used to better understand how these types of reporting biases can impact the validity of research findings, and to develop strategies for minimizing their influence. By simulating different scenarios and analyzing the results, researchers can gain a clearer understanding of the potential impact of deniers and braggers on research findings and can take appropriate steps to reduce the influence of these biases.

* **True prevalence:** number of students using a drug divided by the population.  
* **Deniers:** students who say they have not used a drug but used it. 
* **Braggers:** students who say they have used a drug but never used it. 

We can use a student's response to a drug use question, to estimate the probability of their drug use behavior given hypothetical values of deniers, braggers and the true prevalence.

To model this probability, we can use the **Bayes theorem:**

* **P(A|B)** = Drug use given they say yes in the questionnaire.
* **P(B|A)** = Say yes given that they have used drugs.
* **P(A)** = Drug use prevalence.
* **P(B)** = Say yes in the questionnaire.

## Visit the app [here](https://francisco-cardozo.shinyapps.io/thrusworthy/)


