#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
required_packages = c("scales", "ERSA", "rgdal", "tidyverse", "EpiModel", "network")
need_installed = required_packages[!(required_packages) %in% installed.packages()]
if (length(need_installed) > 0){
    install.packages(need_installed)
}
#Loading packages
lapply(required_packages, require, character.only = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    #output$initialPopulationSize <- renderText({ input$initialPopulationSize})
    output$ProbabilityOfVaccineSuccess <- renderText({ input$ProbabilityOfVaccineSuccess})
    output$ProbabilityOfInfection <- renderText({ input$ProbabilityOfInfection})
    output$NumberOfPeopleContacted <- renderText({ input$NumberOfPeopleContacted})
    

    plots2make = reactive({ 
        
        #N = input$initialPopulationSize # Population size
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
        param <- param.net(inf.prob = I, act.rate = C, rec.rate = P)
        
        #The type  is  'SIS' = Susceptible, Infected, Susceptible 
        #nsteps = the time period, which is 216 days from now (end of september)
        #nsims = number of simulations
        control <- control.net(type = "SIS", nsteps = 216, nsims = 1, epi.by = "risk")
        sim1 <- netsim(est1, param, init, control)
        
        
        est2 <- netest(nw, formation, target.stats, coef.diss)
        # i.num = initial number of people infected (7500), r.num = initial number of people recovered (vaccinated) 550
        init2 <- init.net(i.num = 7500, r.num = 550)
        param2 <- param.net(inf.prob = I, act.rate = C, rec.rate = P)
        #The type  is  'SIR' = Susceptible, Infected, Recovered 
        control2 <- control.net(type = "SIR", nsteps = 216, nsims = 1, epi.by = "risk")
        sim2 <- netsim(est2, param2, init2, control2)
        
        })
    
    
    #-------------------------------------- PLOTS ----------------------------------  
    
        output$PopPlot = renderPlot({
            plots2make()$sim1 %>%
            par(mfrow=c(2,1))
            # si.flow = Number infected, is.flow = number recovered
            plot(sim1, y = c("si.flow", "is.flow"), main = "Figure 1", legend = TRUE)
            
            plot(sim1, y = c("i.num.risk0", "i.num.risk1"), legend = TRUE)
         })
        
        output$PopPlot1 = renderPlot({
            plots2make()$sim1 %>%
            par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
            plot(sim1, type = "network", at = 1, sims = "mean", col.status = TRUE, main = "Figure 2")
            plot(sim1, type = "network", at = 150, sims = "mean", col.status = TRUE, main = "Figure 3")
            plot(sim1, type = "network", at = 10, sims = "mean", col.status = TRUE, main = "Figure 3")
        })
        
   #---------------------------------------- PLOTS ----------------------------------    
        
        
        
        output$PopPlot2 = renderPlot({
            plots2make()$sim2 %>%
                par(mfrow=c(2,1))
            plot(sim2, y = c("si.flow", "ir.flow"), main = "Figure 4", legend = TRUE)
            plot(sim2, y = c("i.num.risk0", "i.num.risk1"), legend = TRUE)
        })
        
        output$PopPlot3 = renderPlot({
            plots2make()$sim2 %>%
                par(mfrow = c(1, 2), mar = c(0, 0, 1, 0))
            plot(sim2, type = "network", at = 1, sims = "mean", col.status = TRUE, main = "Figure 5")
            plot(sim2, type = "network", at = 150, sims = "mean", col.status = TRUE, main = "Figure 6")
        })
        
    
    

})
