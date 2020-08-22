Considering the SEIRS (Susceptible - Exposed - Infectious - Recovered - Susceptible) model for the spreading
of a disease. The compartments are desribed below (Read more at :https://www.idmod.org/docs/hiv/model-seir.html).

- Susceptible : The people in this compartment are not infected but are prone to infection.
- Exposed : The people in this compartment are infected but not infectious (do not infect others). A person
remains in this compartment for t_e timesteps.
- Infectious : The people in this compartment are infected as well as infectious. A person remains in this
compartment for t_i timesteps.
- Recovered : The people in this compartment are recovered and aquires an immunity against the disease for t_r timesteps. After being for t_r timesteps in this compartment, a person switches back to the susceptible
compartment.

Consider the Karate and Dolphin networks. Assuming p to be the probability of infection, implement the
SEIRS model on these networks. Also use this implementation to determine the pseudo-core in the networks.
Tabulate your results for varying values of p, t_i, t_e and t_r.
