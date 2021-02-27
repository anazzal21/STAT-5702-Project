function(){
  
	tabPanel("About",
		HTML("<h1> Ahmad Nazzal </h1>
        <p>
        
        The end result of this project will be to showcase the COVID 19 data and set up a vaccination strategy that will
        streamline the recovery process in Canada. The data presents results collected from all the provinces in Canada and
        the data collected shows the number of confirmed cases, number of deaths, number of people tested, etc. and I hope to draw
        some meaningful conlcuisons from it. 
   
        </p>
        
      	<p>  
      	
	      I am a Graduate Student at Carleton University, and I'm almost done with my first year. 
        Before moving to Canada, I lived in California (Bay Area) and did my Bachelors in Applied Mathematics
		    at San Francisco State University. My passion for Statistics/Data Analysis was sparked by a book I read,
		    The Power of Habit by Charles Duhigg. 
		     
		    </p>"),#end of html part 1.
		
		
        #Notice that I used double quotes (") above because otherwise it would interfere with
        # the single quote in the word (don't)
        HTML('
        <div style="clear: left;">
        </div>
        
        <p>
        <a href="https://www.linkedin.com/in/ahmadnazzal/" target="_blank">LinkedIn</a>
        </p>
        '),#End of html part 2
		value="about"
       
        
	)
  
  

  
  
}
