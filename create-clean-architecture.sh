#!/bin/bash

# Function to create directories
create_directories() {
    mkdir -p cmd/$1
    mkdir -p internal/app
    mkdir -p internal/config
    mkdir -p internal/delivery/http
    mkdir -p internal/domain
    mkdir -p internal/usecase
    mkdir -p internal/repository/mysql
    mkdir -p internal/repository/memory
    mkdir -p pkg/$2
    mkdir -p api
    mkdir -p web/static_files
    mkdir -p scripts
    mkdir -p configs
    mkdir -p test/integration_tests
}

# Function to create files with basic content
create_files() {
    echo 'package main

import (
    "fmt"
)

func main() {
    fmt.Println("Hello, World!")
}' > cmd/$1/main.go

    echo 'package app

import "fmt"

func Run() {
    fmt.Println("Application is running")
}' > internal/app/app.go

    echo 'package config

import (
    "log"
    "gopkg.in/yaml.v2"
    "io/ioutil"
)

type Config struct {
    // Add configuration fields here
}

func LoadConfig(filename string) (*Config, error) {
    data, err := ioutil.ReadFile(filename)
    if err != nil {
        return nil, err
    }
    var config Config
    err = yaml.Unmarshal(data, &config)
    if err != nil {
        return nil, err
    }
    return &config, nil
}' > internal/config/config.go

    echo 'package http

import (
    "net/http"
)

func NewHandler() http.Handler {
    mux := http.NewServeMux()
    // Define your routes here
    return mux
}' > internal/delivery/http/handler.go

    echo 'package domain

type Entity struct {
    // Define entity fields here
}' > internal/domain/entity.go

    echo 'package domain

type Repository interface {
    // Define repository methods here
}' > internal/domain/repository.go

    echo 'package usecase

type Request struct {
    // Define request fields here
}

type Response struct {
    // Define response fields here
}

type Interactor interface {
    Execute(req Request) (Response, error)
}' > internal/usecase/interactor.go

    echo 'package mysql

import (
    "database/sql"
    "fmt"
)

type MySQLRepository struct {
    db *sql.DB
}

func NewMySQLRepository(db *sql.DB) *MySQLRepository {
    return &MySQLRepository{db: db}
}

func (r *MySQLRepository) ExampleMethod() {
    fmt.Println("MySQL repository method")
}' > internal/repository/mysql/mysql_repository.go

    echo 'package memory

type MemoryRepository struct {
    data map[string]interface{}
}

func NewMemoryRepository() *MemoryRepository {
    return &MemoryRepository{
        data: make(map[string]interface{}),
    }
}

func (r *MemoryRepository) ExampleMethod() {
    fmt.Println("Memory repository method")
}' > internal/repository/memory/memory_repository.go

    echo 'package '$2'

func ExampleFunction() string {
    return "Hello from example package!"
}' > pkg/$2/shared_utilities.go

    echo '# Project Name

## Description

A brief description of your project.

## Folder Structure

Explanation of the folder structure and its purpose.

## How to Run

Instructions to run the project.

## Contribution Guidelines

How to contribute to the project.' > README.md

    echo '# Binaries
*.exe
*.exe~
*.dll
*.so
*.dylib

# Output files
*.out

# Dependencies
vendor/' > .gitignore

    echo 'module github.com/username/'$1'

go 1.18

require (
    // List of dependencies
)' > go.mod
}

# Main script
echo "Enter project name:"
read PROJECT_NAME
echo "Enter package name:"
read PACKAGE_NAME

create_directories $PROJECT_NAME $PACKAGE_NAME
create_files $PROJECT_NAME $PACKAGE_NAME

echo "Boilerplate structure created successfully!"