# Program : Plot1.R  ----

# Objectives  ----
#   1. To reconstruct a plot, all of which will be constructed
#      using the base plotting system.
#   2. Construct the plot and save it to a PNG file with 
#      a width of 480 pixels and a height of 480 pixels.
#   3. Push the code R file and PNG file to my GitHub repository:
#      pablojpernia/ExData_Plotting1

# 1.0 Load libraries ----
    library("tidyverse")

# 2.0 Importing Files ----

# 2.1 Download the zip data set, then unzip the data files   

        list.files(".") 

    # Define variables for URL data source, and data file for zipped file
       
        urlfile         <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        datafile        <- "household_power_consumption.zip" 
       
        # Check if data file does not exists        
        
        if (!file.exists (datafile)) {  
          
          download.file(urlfile, datafile, method = "curl")
          unzip(datafile)
        }
        
        # To list files in the directory after downloading  
        
        list.files(".") 
        
# 2.2 Read imported data in tibble data frame structure  

        txt_file <- "household_power_consumption.txt"

        tib_households  <- as_tibble(
                              read.delim(txt_file,
                                         na.strings = "?",
                                         sep = ";"))
                
# 3.0 Examining Data ----
        head(tib_households)
        summary(tib_households)
# 4.0 Wrangling Data ----
        
      # Subset data only for February 1 and 2, year 2007
          
        tib_households_Feb <- subset(tib_households, 
                                     tib_households$Date == "1/2/2007" | 
                                     tib_households$Date == "2/2/2007") 
     
        head(tib_households_Feb)
        summary(tib_households_Feb)
        
        remove(tib_households)    # To release memory
        
     # Combine date and time as Date_Time variable
        
        tib_households_Feb <- tib_households_Feb %>% 
          mutate(Date_Time = strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
     
        # Create final data frame  
        tib_households_wrangled <- tib_households_Feb %>% 
                                      select(Date_Time, 
                                        - c(Date, Time), # Remove Date and Time variables
                                        starts_with("Global"),
                                        starts_with("Vol"), 
                                        starts_with("Sub"))
                                         
        head(tib_households_wrangled)
      
# 5.0 Creating plotted file    ----
        
        # Open a png File
        
        png("plot1.png", 
            width=480, 
            height=480)
        
        # Creating the plot
        
        hist(tib_households_wrangled$Global_active_power, 
             col   = "red",
             main  = "Global Active Power", 
             xlab  = "Global Active Power (kilowatts)")
        
        # Close the png file
        
        dev.off() 

