###################################################################
## File: ui.R
## Title: Course Project: Shiny Application and Reproducible Pitch
## Author: Milen Angelov
## Date: 20th August, 2015
###################################################################

library(shiny);
library(e1071);

shinyUI(
    fluidPage(
        titlePanel("Basic Caret package demo"),
        
        sidebarLayout(
            sidebarPanel(
                sliderInput("data_split", label = "train <-> test split", min = 50, 
                            max = 100, value = c(75, 25)),
                hr(),
                selectInput("tc", "Train Control:", 
                            choices = c("Bootstrap", 
                                        "k-fold Cross Validation",
                                        "Repeated k-fold Cross Validation",
                                        "Leave One Out Cross Validation"),
                            selected = "Bootstrap"),
                hr(),
                radioButtons("method", 
                             label = "Train method",
                             choices = list("Linear Discriminant Analysis" = 1, 
                                            "k-Nearest Neighbors" = 2, 
                                            "Stochastic Gradient Boosting" = 3,
                                            "Mixture Discriminant Analysis" = 4,
                                            "CART" = 5,
                                            "Boosted Logistic Regression" = 6
                             ), 
                             selected = 1),
                hr(),
                actionButton("draw", "Show results")
            ),
            mainPanel(
                h3("Confusion matrix and associated statistics for the model fit:"),
                verbatimTextOutput('predictions')
            )
        )
    )
)