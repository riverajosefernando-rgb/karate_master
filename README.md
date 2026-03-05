# Karate Advanced API Automation Framework

## Overview

This project is an **API Automation Testing Framework** built using **Karate DSL, Java, and Gradle**.
It demonstrates modern testing practices used in **QA Automation, SDET, and CI/CD environments**.

The framework focuses on:

* Maintainable test design
* Reusable data
* Data-driven testing
* Contract validation
* Parallel execution
* Clean architecture

It includes examples of:

* REST API testing
* Scenario Outline with Examples
* Data transformation
* Reusable models
* JSON validation
* Parallel execution

---

# Technologies and Tools

| Technology    | Description                     |
|---------------| ------------------------------- |
| Java 17+      | Runtime environment             |
| Karate DSL    | API automation framework        |
| Gradle 9      | Build and dependency management |
| JUnit 5       | Test execution                  |
| JSON          | Test data format                |
| IntelliJ IDEA | Recommended IDE                 |
| Git           | Version control                 |
| Karate Reports | Execution reporting             |

---

# Key Concepts Implemented

## 1. API Testing with Karate

Karate allows testing APIs using a simple DSL.

Example:

```
Given url baseUrl + '/posts/1'
When method GET
Then status 200
And match response.id == 1
```

Karate automatically handles:

* HTTP calls
* JSON parsing
* Assertions
* Logging

---

# 2. Request and Response Logging

Requests and responses can be logged automatically.

```
Background:
* configure logPrettyRequest = true
* configure logPrettyResponse = true
```

Example output:

```
request:
{
  "title": "test1",
  "body": "body1",
  "userId": 1
}

response:
{
  "id": 101,
  "title": "test1",
  "body": "body1",
  "userId": 1
}
```

---

# 3. Data Driven Testing

Karate supports **Scenario Outline** with examples.

Example:

```
Scenario Outline: Create post

Given url baseUrl + '/posts'
And request { title: <title>, body: <body>, userId: <userId> }

When method POST
Then status 201

Examples:
| title | body | userId |
| test1 | body1 | 1 |
| test2 | body2 | 2 |
```

Benefits:

* Multiple executions
* Reusable scenarios
* Reduced code duplication

---

# 4. External Test Data

Test data can be stored in external JSON files.

Example:

```
* def postData = read('classpath:data/postData.json')
```

Example JSON:

```
[
  {
    "title": "Karate",
    "body": "API testing",
    "userId": 1
  },
  {
    "title": "Automation",
    "body": "Testing framework",
    "userId": 2
  }
]
```

Advantages:

* Separation of concerns
* Easy maintenance
* Data reuse

---

# 5. Data Transformation

Data can be transformed dynamically using JavaScript.

Example:

```
karate.map(read('classpath:data/postData.json'), read('classpath:utils/dataTransformer.js'))
```

Example transformer:

```
function fn(x) {

  x.timestamp = new Date().getTime();
  x.transactionId = java.util.UUID.randomUUID() + '';

  return x;

}
```

This allows:

* Dynamic timestamps
* Random values
* Unique IDs
* Custom payload transformations

---

# 6. Reusable Models

Models allow validating the **structure of API responses**.

Example model:

```
models/postSchema.json
```

Example schema:

```
{
  id: '#number',
  title: '#string',
  body: '#string',
  userId: '#number'
}
```

Validation example:

```
And match response == read('classpath:models/postSchema.json')
```

Benefits:

* Contract validation
* Stable tests
* Reusable validation

---

# 7. Environment Configuration

Global configuration is defined in:

```
karate-config.js
```

Example:

```
function fn() {

  var config = {};
  config.baseUrl = 'https://jsonplaceholder.typicode.com';

  return config;
}
```

This prevents hardcoding URLs.

---

# 8. Test Tags

Tags allow filtering test execution.

Example:

```
@test
Scenario: Create post
```

Runner example:

```
Karate.run("classpath:features")
      .tags("@test");
```

Common tagging strategy:

```
@smoke
@regression
@api
@contract
@negative
@performance
```

Example runner:

```
Karate.run("classpath:features")
      .tags("~@ignore");
```

---

# 9. Parallel Test Execution

Tests can run in parallel using Gradle.

Gradle configuration:

```
test {

    useJUnitPlatform()

    def threads = project.findProperty("threads") ?: "1"

    systemProperty "karate.options", "--threads " + threads

}
```

Execution:

```
gradlew test
```

Parallel execution:

```
gradlew test -Pthreads=3
```
If you prefer not to manually set the number of threads, you can allow the machine to automatically determine the optimal count based on the available CPU cores.
To enable this behavior, simply comment out the following line in the configuration file

```
def threads = project.findProperty("threads") ?: "1"
```

And uncomment out this one: 

```
def threads = project.findProperty("threads") ?: Runtime.runtime.availableProcessors()
```

Tests can run in parallel using Gradle.

---

# Project Structure

```
src
 └─ test
     ├─ java
     │   └─ runners
     │       TestRunner.java
     │
     └─ resources
         ├─ features
         │   ├─ posts
         │   │   createPost.feature
         │   │   createPostAdvance.feature
         │   │
         │   └─ users
         │       getUser.feature
         │
         ├─ data
         │   postData.json
         │
         ├─ models
         │   postSchema.json
         │
         ├─ utils
         │   dataTransformer.js
         │
         └─ karate-config.js
```

---

# Running the Tests

## Using Gradle

Run all tests:

```
gradlew test
```

Run with parallel execution:

```
gradlew test -Pthreads=3
```

---

## Using IntelliJ

1. Open the project
2. Navigate to:

```
TestRunner.java
```

3. Run the runner.

---

# Reports

Karate automatically generates reports:

```
build/karate-reports/
```

Main report:

```
karate-summary.html
```

Includes:

* Feature results
* Scenario results
* Execution time
* Parallel execution stats

---

# Best Practices Implemented

* Separation of test logic and data
* Reusable models for validation
* Externalized configuration
* Clean feature organization
* Data-driven testing
* Parallel execution
* Request/response logging

---

# Future Improvements

Potential framework improvements:

* Authentication (JWT / OAuth)
* API contract testing
* Scenario Outline dynamic data
* CI/CD pipeline integration
* Advanced reporting
* Mock services with Karate
* Performance testing integration

---

# Author

This framework was created as a **learning and demonstration project for QA Automation using Karate DSL**.

It demonstrates **best practices for modern API test automation frameworks used by SDET and Automation Engineers**.
