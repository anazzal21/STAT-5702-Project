# Server

library(shiny)
required_packages = c("scales", "ERSA", "rgdal", "tidyverse", "EpiModel", "network")
need_installed = required_packages[!(required_packages) %in% installed.packages()]
if (length(need_installed) > 0){
  install.packages(need_installed)
}
#Loading packages
lapply(required_packages, require, character.only = TRUE)

P = input$ProbabilityOfVaccineSuccess # Probability of Vaccine Success (Recovery)
I = input$ProbabilityOfInfection
C = input$NumberOfPeopleContacted


#set.seed(12345)
nw <- network::network.initialize(n = 20000, directed = FALSE)
nw <- network::set.vertex.attribute(nw, "risk", rep(0:1, each = 300))
formation <- ~ edges + nodefactor("risk") + nodematch("risk") + concurrent
target.stats <- c(2134, 2673, 1100, 1983)
coef.diss <- dissolution_coefs(dissolution = ~ offset(edges), duration = 80)
est1 <- netest(nw, formation, target.stats, coef.diss)

# i.num = initial number of people infected
init <- init.net(i.num = 7500)

#inf.prob = probability of infection, act.rate = number of people contacted, rec.rate = vaccine success (recovery rate)
param <- param.net(inf.prob = 0.8, act.rate = 70, rec.rate = 0.3)

#The type  is  'SIR' = Susceptible, Infected, Recovered. 
#nsteps = the time period, which is 216 days from now (end  of september)
#nsims = number of simulations, will turn into a variable
control <- control.net(type = "SIS", nsteps = 216, nsims = 1, epi.by = "risk")
sim1 <- netsim(est1, param, init, control)


est2 <- netest(nw, formation, target.stats, coef.diss)
init2 <- init.net(i.num = 7500, r.num = 550)
param2 <- param.net(inf.prob = 0.3, act.rate = 70, rec.rate = 0.8)
control2 <- control.net(type = "SIR", nsteps = 216, nsims = 1, epi.by = "risk")
sim2 <- netsim(est2, param2, init2, control2)





plot(sim1, type = "network", at = 1, sims = "mean", col.status = TRUE, main = "Figure 2")
plot(sim1, type = "network", at = 150, sims = "mean", col.status = TRUE, main = "Figure 3")

plot(sim2, type = "network", at = 1, sims = "mean", col.status = TRUE, main = "Figure 5")
plot(sim2, type = "network", at = 150, sims = "mean", col.status = TRUE, main = "Figure 6")