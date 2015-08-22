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
        helpText("Very basic demonstration of the caret package which is a set 
                 of functions that attempt to streamline the process for creating predictive models."),
        sidebarLayout(
            sidebarPanel(
                helpText("Select what part of the input data to be used for training of the model.
                         Data splitting involves partitioning the data into an explicit 
                         training dataset used to prepare the model and an unseen test dataset."),
                sliderInput("data_split", label = "train <-> test split in %", min = 50, 
                            max = 100, value = 75, step = 5),
                hr(),
                helpText("Select train control to be used. It is used 
                         to estimate model accuracy."),
                selectInput("tc", "Train Control:", 
                            choices = c("Bootstrap", 
                                        "k-fold Cross Validation",
                                        "Repeated k-fold Cross Validation",
                                        "Leave One Out Cross Validation"),
                            selected = "Bootstrap"),
                hr(),
                helpText("Choose model to be used."),
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
                actionButton("draw", "Do predictions")
            ),
            mainPanel(
                h3("Confusion matrix and associated statistics for the model fit:"),
                verbatimTextOutput('predictions')
            )
        )
    )
)