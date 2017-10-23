using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace lab2
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        public Form1()
        {   
                InitializeComponent();
                connection = new SqlConnection(@"Data Source = VALENTINE\SQLEXPRESS; Initial Catalog = Kpi2; Integrated Security = True");
            }

        private void buttonClearTable_Click(object sender, EventArgs e)
        {

            connection.Open();
            string queryString =
            " CREATE TABLE[Clients](" +
            "[ClientID] INT IDENTITY(1,1) NOT NULL," +
            "[FirstName] NVARCHAR(255) NOT NULL," +
            "[LastName] NVARCHAR(255) NOT NULL," +
            "[MiddleName] NVARCHAR(255)NOT NULL," +
            "[Phone] NVARCHAR(255)," +
            "CONSTRAINT PK_ClientID PRIMARY KEY CLUSTERED(ClientID))";
            SqlCommand command = new SqlCommand(
            queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        private void buttonFillTable_Click(object sender, EventArgs e)
        {

        }

        private void buttonExecuteQuery_Click(object sender, EventArgs e)
        {

        }

        private void buttonCreateIndex_Click(object sender, EventArgs e)
        {

        }

        private void buttonDeleteIndex_Click(object sender, EventArgs e)
        {

        }
    }
}
