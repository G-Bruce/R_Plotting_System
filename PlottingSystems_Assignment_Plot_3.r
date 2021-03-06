# ------------------------------  COURSERA - PLOTTING SYSTEMS PROGRAMMING ASSIGNMENT ------------------------------
ORG_WD<-getwd()
setwd("L:/Coursera/DataScience/R_Plotting_Systems")

# -------------------------------------------- IMPORT RAW DATA ----------------------------------------------------
rm("raw_data","rd_complete_cases","StartOfOperation","TotalProcessorTime", "rd_cc_dates", "rd_cc_ss_active","rd_cc_ss_dt_strptime")
# Start THE PROCESSOR TIME CLOCK TO MEASURE HOW LONG IT TAKES TO IMPORT DATA INTO MEMORY
#StartOfOperation <- proc.time()
raw_data<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                       stringsAsFactors = FALSE, na.strings="?",
                       colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric",
                                      "numeric","numeric","numeric"),
                       col.names = c("Date", "Time", "Active", "Reactive","Voltage", "Intensity", "Meter_1",
                                     "Meter_2", "Meter_3"))


# STOP THE PROCESSOR CLOCK
#TotalProcessorTime <-proc.time() - StartOfOperation
#write.csv(raw_data,"raw_data.csv", col.names = TRUE, sep = ",", na = "NA")

# -------------------------------- REMOVE NA VALUES ---------------------------------------------------------------
#SLOWER THAN COMPLETE.CASES
#StartOfOperation <- proc.time()
#raw_data_no_na <- na.omit(raw_data)
#no_na <-proc.time() - StartOfOperation
# write.csv(raw_data_no_na,"raw_data_no_na.csv", col.names = TRUE, sep = ",", na = "NA")

#StartOfOperation <- proc.time()
rd_complete_cases <- raw_data[complete.cases(raw_data), ]


#complete_cases <-proc.time() - StartOfOperation
#write.csv(rd_complete_cases,"rd_complete_cases.csv", col.names = TRUE, sep = ",", na = "NA")
# -------------------------------- SUBSET BASED UPON DATE ---------------------------------------------------------
# FILTER FOR 2007-02-01 and 2007-02-02
# NATIVE FORMAT d-m-Y

rd_cc_dates <- rd_complete_cases[rd_complete_cases$Date %in% c("1/2/2007","2/2/2007") ,]
#write.csv(rd_cc_dates,"rd_cc_dates.csv")

# --------------------------------- COMBINING DATE AND TIME -------------------------------------------------------

rd_cc_ss_dt_strptime <- strptime(paste(rd_cc_dates$Date, rd_cc_dates$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Sub_Metering_1 <- rd_cc_dates$Meter_1
Sub_Metering_2 <- rd_cc_dates$Meter_2
Sub_Metering_3 <- rd_cc_dates$Meter_3

# ------------------------------------ PLOTTING -------------------------------------------------------------------
# ------------------------------- PLOT 3 SUB METERING ---------------------------------------------------------
png("Plot_3.png", width=480, height=480)
plot(rd_cc_ss_dt_strptime, Sub_Metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(rd_cc_ss_dt_strptime, Sub_Metering_2, type="l", col="red")
lines(rd_cc_ss_dt_strptime, Sub_Metering_3, type="l", col="blue")
legend("topright", c("1", "2", "3"), lty=1, lwd=5, col=c("black", "red", "blue"))
mtext("Sub Metering", outer = FALSE)
dev.off()
# --------------------------------- CLOSEOUT PROCESSES ------------------------------------------------------------

setwd(ORG_WD)

