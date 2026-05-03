# Issue: Improve "Add Product" Feature UI and Input

## Description
The current "Add Product" form in the Inventory Management System requires UI and UX improvements. Specifically, the manual text inputs for dates (Manufacturing Date - MFD and Expiry Date) are prone to formatting errors and should be replaced with graphical date pickers. Additionally, the overall layout of the "Add Product" panel needs refinement to be visually appealing and user-friendly.

## Tasks

### 1. Integrate Date Picker for MFD and Expiry Dates
- Replace the existing `JTextField` components for Manufacturing Date (`mfd`) and Expiry Date (`expd`) in the "Add Product" panel (`jPanel11` in `Mainpage.java`) with `JDateChooser` from the JCalendar library.
- Ensure the `JCalendar` library (`jcalendar-1.4.jar`) is added to the project's build path/dependencies.
- Update the action handler for the "Add Product" button (e.g., `jButton1ActionPerformed`) to retrieve the selected dates from the `JDateChooser` components.
- Format the retrieved dates to `yyyy-MM-dd` format using `SimpleDateFormat` before inserting them into the PostgreSQL database.

### 2. Improve Layout of "Add Product" Panel
- Redesign the layout for `jPanel11` in `Mainpage.java` to make the form more visually appealing.
- Align labels and input fields correctly for better readability.
- Ensure consistent spacing and padding between form components.
- Make the "Add" button prominent and well-placed at the bottom of the form.

## Implementation Details / Context
- **Target File:** `src/ism/Mainpage.java`
- **Database:** The application uses a PostgreSQL database (`inventory_db`). Ensure the date formats passed to the JDBC driver are compatible.
- **Dependencies:** The JCalendar library (`jcalendar-1.4.jar` or similar) needs to be downloaded and configured in the project's library settings.

## Acceptance Criteria
- [ ] Users can select MFD and Expiry Date using a graphical calendar component instead of typing manually.
- [ ] Selected dates are correctly processed and saved to the database without SQL errors.
- [ ] The "Add Product" form looks modern, aligned, and professional.
- [ ] The core functionality of adding a product remains intact and fully functional.
