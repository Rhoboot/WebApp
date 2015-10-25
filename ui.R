DMAT<-read.csv("./data/DATAMAT.csv",header=TRUE,sep=";",dec=",") 
DMAT<-DMAT[complete.cases(DMAT),]
library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(shiny)
library(googleVis)
library(shinyjs)

shinyUI(
        fluidPage(titlePanel("Math Diagnostic Test",windowTitle = "DMAT"),
                     h2("Exploratory analysis of Percentage Achievement", align = "left"),
                     sidebarLayout(sidebarPanel(
                             selectInput('x','Select a variable:',
                                         choice=names(DMAT[-c(8,18,19)])),
                             radioButtons("campus","Campus:",c("Both" = "both", "Santiago" = "S", "Viña" = "V")),
                             radioButtons("programs","Programs of Study:",c("Both" = "both", "Business Administration" = "COM", "Civil Engineering" = "IND")),
                             colourInput("col", "Select the color of plot",
                                         value="#17BECF",showColour="background",
                                         palette = "limited",
                                         allowedCols=c("#1F77B4","#FF7F0E","#2CA02C","#D62728","#9467BD",
                                                       "#8C564B","#E377C2","#7F7F7F","#AEC7E8","#FFBB78",
                                                       "#98DF8A","#FF9896","#C5B0D5","#C49C94","#F7B6D2",
                                                       "#C7C7C7","#BCBD22","#DBDB8D","#17BECF","#9EDAE5")),
                             img(src="Firma.png", height = 30, width = 117.6)),
                             mainPanel(tabsetPanel(type = "tabs",
                                                   tabPanel(p(icon("pie-chart","fa-2x"),"Plot's"),
                                                            textOutput("text2"),
                                                            plotOutput('regPlot',
                                                                       click = "plot_click",
                                                                       brush = brushOpts(id = "plot_brush")),
                                                            plotOutput("distPlot"),
                                                            actionButton("exclude_points", "Exclude points"),
                                                            actionButton("exclude_reset", "Reset")),
                                                   tabPanel(p(icon("table","fa-2x"),"Correlation"),
                                                            br(),h2("Correlation Table"),
h5("The following table shows the correlation between the percentage of Achievement and other variables of interest."),
                                                htmlOutput("corr"),
                                                HTML('</br> </br>')
                                                   ),
                                                   tabPanel(p(icon("line-chart","fa-2x"),"Regression"),h2("Summary Linear Regression"), textOutput("text1"),                   
                                                            verbatimTextOutput("model")),
                                                   tabPanel(p(icon("book","fa-2x"),"Codebook"),includeMarkdown("include.Rmd")),
                                                   tabPanel(p(icon("file-text","fa-2x"),"Documentation"),includeMarkdown("documentation.Rmd")),
                                                   tabPanel(p(icon("code","fa-2x"),"Code"),includeMarkdown("CodeApp.Rmd")))        
                             )
                             
                     )))