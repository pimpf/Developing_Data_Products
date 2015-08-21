###################################################################
## File: server.R
## Title: Course Project: Shiny Application and Reproducible Pitch
## Author: Milen Angelov
## Date: 20th August, 2015
###################################################################

library(caret)
library(ggplot2);
library(MASS);
library(kknn);
library(gbm);
library(plyr);
library(mda);
library(rpart);
library(caTools);

data(iris);

shinyServer(function(input, output) {
    
    v <- reactiveValues(drawResults = FALSE);
    
    observeEvent(input$draw, {
        v$drawResults <- input$draw;
    })
    
    output$predictions <- renderPrint({
        if (v$drawResults == FALSE) 
            return();
        
        isolate({
            
            withProgress(message = 'Progress...', value = 0, {
                
                ## Split data 
                trainIndex <- createDataPartition(iris$Species, p=(input$data_split[1]/100), 
                                                  list=FALSE);
                
                data_train <- iris[ trainIndex,];
                data_test <- iris[-trainIndex,];
                
                incProgress(0.25, detail = "Defining train control");
                
                ## Define train control from the selection
                tc <- if(input$tc == "Bootstrap"){
                    trainControl(method="boot", number=100);
                } else if (input$tc == "k-fold Cross Validation" ){
                    trainControl(method="cv", number=10);        
                } else if (input$tc == "Repeated k-fold Cross Validation" ){
                    trainControl(method="repeatedcv", number=10, repeats=3);
                } else {
                    trainControl(method="LOOCV");
                }
                
                incProgress(0.5, detail = "Computing model from the chosen method");
                
                ## Not sure if this is needed here, but let's assure reproducability
                set.seed(54321);
                
                ## Fit model from the chosen method
                model <- if(input$method == 1){
                    train(Species~., data=data_train, trControl=tc, method="lda");
                } else if(input$method == 2){
                    train(Species~., data=data_train, trControl=tc, method="kknn");
                } else if(input$method == 3){
                    train(Species~., data=data_train, trControl=tc, method="gbm");
                } else if(input$method == 4){
                    train(Species~., data=data_train, trControl=tc, method="mda");
                } else if (input$method == 5){
                    train(Species~., data=data_train, trControl=tc, method="rpart");
                } else {
                    train(Species~., data=data_train, trControl=tc, method="LogitBoost");
                }
                
                incProgress(0.75, detail = "Making predictions on test data");
                
                ## Make predictions
                predictions <- predict(model, newdata = data_test);
                
                ## Print Confusion matrix
                confusionMatrix(predictions, data_test$Species);

            })
        })
    })
})