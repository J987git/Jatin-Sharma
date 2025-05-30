#  Hospital Readmission Prediction

This project aims to predict whether a patient will be readmitted to the hospital using medical and demographic data. Early identification of patients at risk for readmission can help improve healthcare planning and reduce costs.

---

##  Objective

To build a classification model that predicts hospital readmission (Yes/No) based on patient data such as medical specialty, age, number of inpatient visits, lab procedures, and more.

---

##  Dataset


- Key columns:
  - `age`
  - `medical_specialty`
  - `number_inpatient`
  - `number_emergency`
  - `time_in_hospital`
  - `num_lab_procedures`
  - `readmitted` (target)

---

## Preprocessing

- Removed missing and irrelevant values.
- Encoded categorical variables using `LabelEncoder`.
- Focused on binary classification (`readmitted`: Yes/No).
- Selected key features with predictive power:
  - `medical_specialty`, `age`, `number_inpatient`, `number_emergency`, `time_in_hospital`, `num_lab_procedures`, `number_diagnoses`

---

##  Models Used

- **Logistic Regression** with `class_weight='balanced'`
- **Random Forest Classifier**

---

##  Evaluation Metrics

**Logistic Regression (Best Model):**

| Metric        | Class 0 (No) | Class 1 (Yes) |
|---------------|--------------|---------------|
| Precision     | 0.62         | 0.58          |
| Recall        | 0.73         | 0.45          |
| F1-Score      | 0.67         | 0.51          |
| Accuracy      | 60%          | -             |

**Confusion Matrix:**

[[1008 369]
[ 629 518]]

yaml
Copy
Edit

---

##  Key Insights

- The model achieved **60% accuracy**, with significantly improved recall and F1-score for readmitted patients compared to earlier versions.
- Adding features like `number_inpatient` and `number_emergency` improved prediction performance.
- Logistic Regression outperformed Random Forest slightly in accuracy and precision.
- Class balancing helped reduce bias toward the majority class.
