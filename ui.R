#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#install.packages("ERSA")
#install.packages("scales")
#install.packages("shiny")




# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Simulating the spread of Covid-19 while considering the Vaccine"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            p("Population Size: 20,000"),
            numericInput("initialPopulationSize", "Population Size: 20000", 20000),
            
            sliderInput("ProbabilityOfVaccineSuccess",
                        "Probability of vaccine success:",
                        min = 0.10,
                        max = 0.80,
                        value = .15,
                        step = .05),
            sliderInput("ProbabilityOfInfection",
                        "Probability of Infection:",
                        min = 0.10,
                        max = 1,
                        value = .7,
                        step = .05),
            sliderInput("NumberOfPeopleContacted",
                        "How many people contacted?:",
                        min = 30,
                        max = 80,
                        value = 70,
                        step = 1),
            
            #numericInput("xmin", "x-axis minimum:", 1000),
            #numericInput("xmax", "x-axis maximum value:", 1000000),
            
            #checkboxInput("DensityLogical", strong("Add a density plot?"), FALSE),
            submitButton("Submit"),
            
            #radioButtons("dataSource", "", c("Canada" = "CanadaCovid", "Ontario" = "OntarioCovid")),
            
        ),
        
        

        # Show a plot of the generated distribution
        mainPanel(
   
          tabsetPanel(type = "tabs", 
                      
                      tabPanel("Simulation", HTML("<h1> Analysis </h1>
            <p> <b> Understanding the Project - Defining what's best </b> </p>
            
            <p> 
            Initially: I came across data on the GitHub website provided by Dr. Campbell. I spent a lot of time trying to piece together
            an approach to analyzing the data, but couldn't stick to something concrete. I knew I needed to take a completely different 
            approach because the values I had weren't feasible  to create a concrete simulation. While referencing Dr. Campbell's code,
            I went out and did my own research on the topic (epidemiology, modeling, etc.) and  how  I can apply a different approach to it 
            in R. </p> 
            
            <p> 
            
            <b> Describing Input values: </b>
            
            </p>
            
            <p>
            
            - Probability of Vaccine Success: 
            
             </p>
             
             <p> This value will impact the recovery variable in the program. You can decide how effective the vaccine will be by adjusting it. </p>
             
              <p>
            
            - Probability of Infection:
            
             </p>
             
             <p> This will impact the probability of infection when the nodes (people) come in contact with eachother (A visual will be provided)  </p>
             
              <p>
            
            - How many people contacted?:
            
             </p>
             
             <p> The number of interaction between the nodes (people) in each time step (Set to 216 because that's how many days there are until the end
             of September.) </p>

            <br> </br> 
                                                  
            
            </p>"),
                               
        HTML('<div style="clear: left;"> </div>
        
        <b> Resources Used </b>
        
        <p>
        <a href="https://github.com/iamdavecampbell/STAT5702-2021" target="_blank">Dr.Campbells GitHub</a>
        </p>
        
        <p>
        <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5931789/" target="_blank">Samuel M. Jenness</a>
        </p>
        '),
                               
           HTML("
           
           <p>I am looking to measure how effective the Vaccine will be when given while taking 'herd immunity' into mind. Figure 1, Figure 2, and Figure 3 
           represent the results of herd immunity, while Figure 4, Figure 5, and Figure 6 account for when a vaccine is given to people. The 'best' in my opinion
           is to vaccinate as many people as possible (especially those  who are most at risk) in order to curb the spread of the virus and wash it out of society.</p>
           
           <p>In the first output of Figure 1, you can see that if Covid is left unchecked (herd immunity), those who are Susciptble (can get infected) will go through 
           the process of getting infected and then kicking the disease, but that pattern will repeat itself. There also seems to be an overlap (increasing) because
           the pattern continues with no end in sight. The group that is at risk (in Red, and aged 60+) will continue to  grow while those who are not at risk will
           continue to stay the same (This program does not account for mutated strains of Covid). 'is.flow' accounts for those who recovered, 'si.flow' accounts
           for  those who are infected. </p>
           
           <p>In the second output of Figure 1, you can see that the group that is most at risk (i.num.risk1, aged 60 and older) will continue to grow, while the group that 
           isn't at risk (i.num.risk0, less than 60 years old) will stabalize  and remain the same throughout. Clearly nothing will be done here to imporve the case.</p> 
           
           <p>In Figures 2 and 3, we can see a visual of that with the nodes representing humans from when the time interval is 1 and 200. Over time, there are still
           people who are infected and the number  of those only increases. </p>
           
           
           Describe what I'm measuring and relate the 'best' to output. 
            Figure 1,  Figure 2, Figure 3, SIS model where even with recovery rate  people are still susciptble to disease") ,                   
            plotOutput("PopPlot"), 
            plotOutput("PopPlot1"),
            
            HTML(" <p>For the second part of this, we'll be looking at what happens when a population of people is vaccinated. </p>
            
            <p>In the first output of Figure 4, we can see that the number of people infected 'si.flow' and the number of people who need to recover 'is.flow' 
            flatens out and goes to 0. </p>
            
            <p>In the second output of Figure 4, we can see that the number of those who are most at risk 'i.num.risk1' starts at a high value but gradually decreases
            along with those who aren't.</p>
            
            <p> In Figure 5, we can see a population of normal people where some of them have been vaccinated (green dots) and there are still people who
            are infected (red dots). Over time (In figure 6) you no longer have people who are infected and there's more green dots present. (Represents the need to 
            vaccinate a certain number of people in order for the virus to become obsolete).</p> "),
            
            plotOutput("PopPlot2"),
            plotOutput("PopPlot3")),
                      
            tabPanel("Future Analysis", HTML("<h2> What could be improved on? </h2>
            <p> <b> Time Complexity: </b> </p>
            
            <p> 
            
            It takes a long time to run the program depending on what metrics are used. To improve this I will explore different approaches to
            how I could speed up the simulaiton process. It would also help to scale the program to a point where the population value can be 
            a whole lot larger.
            
            </p> 

            <p> <b> Other values </b> </p>
            
            One of the factos that I wasn't able to include in this (becuase it would complicate the process) was Age. I would like to explore
            different avenues where I can incorporate Age as value from 1-100 into the model, and even desginate a certain percentage of the 
            population to reflect a certain age. 
            <p>
            
            <p> <b> Mortality </b> </p>
            I would like to somehow incorporate the probability of dying from covid into the program itself and setting up visuals to help understand it. 
            
            <br> </br> 
                                                  
            
            </p>")),
                      
            tabPanel("About",source("about.R")$value())), #This is the new tab with some info
          
          
        )
        
    )
  
)

)
