namespace lab2
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonClearTable = new System.Windows.Forms.Button();
            this.buttonFillTable = new System.Windows.Forms.Button();
            this.CountRows = new System.Windows.Forms.RichTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.timeFill = new System.Windows.Forms.RichTextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.timeExecute = new System.Windows.Forms.RichTextBox();
            this.buttonExecuteQuery = new System.Windows.Forms.Button();
            this.buttonCreateIndex = new System.Windows.Forms.Button();
            this.buttonDeleteIndex = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonClearTable
            // 
            this.buttonClearTable.Location = new System.Drawing.Point(164, 38);
            this.buttonClearTable.Name = "buttonClearTable";
            this.buttonClearTable.Size = new System.Drawing.Size(121, 42);
            this.buttonClearTable.TabIndex = 0;
            this.buttonClearTable.Text = "Очистити таблицю";
            this.buttonClearTable.UseVisualStyleBackColor = true;
            // 
            // buttonFillTable
            // 
            this.buttonFillTable.Location = new System.Drawing.Point(164, 86);
            this.buttonFillTable.Name = "buttonFillTable";
            this.buttonFillTable.Size = new System.Drawing.Size(121, 42);
            this.buttonFillTable.TabIndex = 1;
            this.buttonFillTable.Text = "Наповнити таблицю";
            this.buttonFillTable.UseVisualStyleBackColor = true;
            // 
            // CountRows
            // 
            this.CountRows.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.CountRows.Location = new System.Drawing.Point(295, 57);
            this.CountRows.Name = "CountRows";
            this.CountRows.Size = new System.Drawing.Size(121, 23);
            this.CountRows.TabIndex = 2;
            this.CountRows.Text = "500000";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(292, 38);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(126, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Ввести кількість рядків";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(292, 86);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Час виконання:";
            // 
            // timeFill
            // 
            this.timeFill.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.timeFill.Location = new System.Drawing.Point(295, 105);
            this.timeFill.Name = "timeFill";
            this.timeFill.Size = new System.Drawing.Size(121, 23);
            this.timeFill.TabIndex = 4;
            this.timeFill.Text = "";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(292, 134);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(87, 13);
            this.label3.TabIndex = 8;
            this.label3.Text = "Час виконання:";
            // 
            // timeExecute
            // 
            this.timeExecute.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.timeExecute.Location = new System.Drawing.Point(295, 153);
            this.timeExecute.Name = "timeExecute";
            this.timeExecute.Size = new System.Drawing.Size(121, 23);
            this.timeExecute.TabIndex = 7;
            this.timeExecute.Text = "";
            // 
            // buttonExecuteQuery
            // 
            this.buttonExecuteQuery.Location = new System.Drawing.Point(164, 134);
            this.buttonExecuteQuery.Name = "buttonExecuteQuery";
            this.buttonExecuteQuery.Size = new System.Drawing.Size(121, 42);
            this.buttonExecuteQuery.TabIndex = 6;
            this.buttonExecuteQuery.Text = "Виконати запит";
            this.buttonExecuteQuery.UseVisualStyleBackColor = true;
            // 
            // buttonCreateIndex
            // 
            this.buttonCreateIndex.Location = new System.Drawing.Point(164, 182);
            this.buttonCreateIndex.Name = "buttonCreateIndex";
            this.buttonCreateIndex.Size = new System.Drawing.Size(121, 42);
            this.buttonCreateIndex.TabIndex = 9;
            this.buttonCreateIndex.Text = "Створити індекс";
            this.buttonCreateIndex.UseVisualStyleBackColor = true;
            // 
            // buttonDeleteIndex
            // 
            this.buttonDeleteIndex.Location = new System.Drawing.Point(164, 230);
            this.buttonDeleteIndex.Name = "buttonDeleteIndex";
            this.buttonDeleteIndex.Size = new System.Drawing.Size(121, 42);
            this.buttonDeleteIndex.TabIndex = 10;
            this.buttonDeleteIndex.Text = "Видалити індекс";
            this.buttonDeleteIndex.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(587, 331);
            this.Controls.Add(this.buttonDeleteIndex);
            this.Controls.Add(this.buttonCreateIndex);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.timeExecute);
            this.Controls.Add(this.buttonExecuteQuery);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.timeFill);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.CountRows);
            this.Controls.Add(this.buttonFillTable);
            this.Controls.Add(this.buttonClearTable);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClearTable;
        private System.Windows.Forms.Button buttonFillTable;
        private System.Windows.Forms.RichTextBox CountRows;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.RichTextBox timeFill;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.RichTextBox timeExecute;
        private System.Windows.Forms.Button buttonExecuteQuery;
        private System.Windows.Forms.Button buttonCreateIndex;
        private System.Windows.Forms.Button buttonDeleteIndex;
    }
}

