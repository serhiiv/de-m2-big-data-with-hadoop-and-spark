# README

- Create cluster
  - `terraform init`
  - `terraform apply`
  - setup zeppelin hive interpreter
    - %jdbc
      - Properties
        - #Name	              #Value
        - hive.driver         org.apache.hive.jdbc.HiveDriver	
        - hive.splitQueries   true	
        - hive.url            jdbc:hive2://localhost:10000	
      - #Artifact
        - org.apache.hive:hive-jdbc:3.1.3	
        - org.apache.hadoop:hadoop-common:3.0.0	
- For prepear data download and run zpln-files `Task 1`, `Task 2` and `Task 3`
- Solve tasks `Task 4` and `Task 5`
- Destroy cluster
  - `terraform destroy`
