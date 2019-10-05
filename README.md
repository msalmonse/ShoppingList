# ShoppingList

Shopping list using Core Data for storage and SwiftUI

## Home Tab

## Categories Tab

## Products Tab

## Stores Tab

## Settings Tab

## Core Data Schema

![Core Data Schema](Images/schema.png)

### Category
- Attributes
  - id
  - name
- Relationships
  - entries
  - products
  - stores

### Entry
- Attributes
  - completed
  - id
  - quantity
- Relationships
  - category
  - product
  - stores

### Product
- Attributes
  - id
  - manufacturer
  - name
- Relationships
  - category
  - entries

### Store
- Attributes
  - branch
  - id
  - name
- Relationships
  - category
  - entries
