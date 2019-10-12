# ShoppingList

Shopping list using Core Data for storage and SwiftUI

## Home Tab
<img title="Home Tab" src="Images/home.png" height="453" width="250"> <img src="Images/right-arrow.png" style="vertical-align: middle"> <img title="Entry Actions" src="Images/entry-action.png" height="453" width="250"> -> <img title="Entry Edit" src="Images/entry-edit.png" height="453" width="250">

## Categories Tab
<img title="Categories Tab" src="Images/categories.png" height="453" width="250"> -> <img title="Category Actions" src="Images/category-action.png" height="453" width="250"> -> <img title="Category Edit" src="Images/category-edit.png" height="453" width="250">

## Products Tab
<img title="Products Tab" src="Images/products.png" height="453" width="250"> -> <img title="Entry Actions" src="Images/product-action.png" height="453" width="250"> -> <img title="Entry Edit" src="Images/product-edit.png" height="453" width="250">

## Stores Tab
<img title="Home Tab" src="Images/stores.png" height="453" width="250"> -> <img title="Entry Actions" src="Images/store-action.png" height="453" width="250"> -> <img title="Entry Edit" src="Images/store-edit.png" height="453" width="250">

## Settings Tab

There are no settings as yet.

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
  - name (actually Product.name)
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
