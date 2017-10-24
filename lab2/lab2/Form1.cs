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
using System.Diagnostics;

namespace lab2
{
    public partial class Form1 : Form
    {
        string[] FirstNames;
        string[] LastNames;
        string[] MiddleNames;
        SqlConnection connection;
        public Form1()
        {
            InitializeComponent();
            FirstNames = new string[] { "Karen", "Dong", "Belen", "Codi", "Anneliese", "Troy", "Blaine", "Sherwood", "Arcelia", "Illa", "Shauna", "Gabrielle", "Lanora", "Neva", "Georgine", "Vivien", "Cruz", "Brandon", "Rory", "Kimbery", "Consuelo", "Deangelo", "Keiko", "Leonila", "Dannie", "Avery", "Kacey", "Hilde", "Raina", "Danette", "Tonette", "Tristan", "Gina", "Rashida", "Shawnna", "Alicia", "Loreen", "Eddie", "Kimberlie", "Roseline", "Vannessa", "Dot", "Leslie", "Clarence", "Tod", "Marcos", "Minerva", "Consuela", "Betty", "Pamula", "Carolyne", "Marlen", "Nichole", "Richie", "Tamela", "Jamee", "Suzi", "Marcellus", "Daria", "Clarisa", "George", "Trudy", "Tiny", "Suzan", "Lasonya", "Sybil", "Octavia", "Corene", "Concetta", "Titus", "Lidia", "Thanh", "Kiana", "Melodie", "Lucy", "Fletcher", "Leonie", "Trudi", "Jerrold", "Mollie", "Ashlee", "Yoshiko", "Andre", "Yoshie", "Alica", "Phylis", "Eric", "Jillian", "Artie", "Carissa", "Elizebeth", "Mable", "Jenee", "Conception", "Natasha", "Jammie", "Josette", "Wendolyn", "Norman", "Carlotta" };
            LastNames = new string[] { "Hotson", "Grosvenor", "Carlyle", "De Velville", "Curzon-Howe", "Randolph", "Willhite", "Teavis", "Burrows", "Mcgettigan", "Dunlop", "Rennie", "Weatherhill", "Todhunter", "Holcroft", "Studd", "Daniell", "Toone", "Sheild", "Naumann", "Physick", "Rostron", "Nitschke", "Elkin", "Devereux", "Jenns", "Cage", "Greswolde-Williams", "Woodhouse", "Ross-Skudder", "Leybourne", "Hoks", "Cavers", "Oldfield", "Orbell", "Greer", "Herd", "Netern", "Dorothy", "Lupton", "Donnely", "Lester", "Fenner", "Cron", "Hewson", "Redhead", "Blanks", "Neelin", "Murray", "Theakston", "Festing", "Goodeve", "Nethercote", "Wilmoth", "Muirhead", "Trippett", "Huddlestone", "Salman", "Elliott", "Honeyman", "Macallister", "Sim", "Thomlinson", "Pickles", "Kinnish", "Marfleet", "Bottoms", "Vanstan", "De Aldburgh", "Gilbraith", "Jensen", "Kelland", "Tedford", "Saul", "Pearl", "Ferrant", "Livsey", "Rule", "Whittington", "Corton", "Nicklenson", "Edmunds", "Macfie", "Flinders", "Dorynne", "Cresmer", "Dawtry", "Plant", "Wriggle", "Laroche", "Chisnall", "Lowrie", "Gall", "Bell", "Druistan", "Sowerby Battye", "Milbourne", "Glencross", "Robey", "Stott" };
            MiddleNames = new string[] { "Alexeyevich", "Nikitevich", "Denisovich", "Andreevich", "Onisimovich", "Sidorovich", "Leonidovich", "Ernstovich", "Artemievich", "Erofeevich", "Filimonovich", "Ipatovich", "Epifanovich", "Serafimovich", "Pakhomovich", "Glebovich", "Filimonovich", "Onisimovich", "Andreevich", "Svyatoslavovich", "Dmitrievich", "Eremeevich", "Arsenievich", "Gerasimovich", "Davydovich", "Artemievich", "Feliksovich", "Kirillovich", "Vyacheslavovich", "Klimentovych", "Grigoryevich", "Socratovich", "Nikanorovich", "Modestovic", "Jakowowicz", "Nikitevich", "Ostapovich", "Gordeyevich", "Nikiforovich", "Daniilovich", "Izmailovich", "Semenovich", "Makarovich", "Valeryanovich", "Prohorovich", "Adamovich", "Samuilovich", "Grigoryevich", "Feliksovich", "Valerievich", "Vladimirovich", "Glebovich", "Yelizarovich", "Nestorovich", "Vladislavovich", "Danilevich", "Tikhonovich", "Levovich", "Leonidovich", "Valerievich", "Ippolitovich", "Kondratievich", "Epifanovich", "Onisimovich", "Kondratievich", "Andronovych", "Savelievich", "Prokilovich", "Sidorovich", "Pankratievich", "Karlovich", "Ipatievich", "Venediktovych", "Sigismundovich", "Gavrilevich", "Feliksovich", "Afanasyevich", "Klimentovych", "Adrianovich", "Czeslawowicz", "Sidorovich", "Mikhailovich", "Vadimovich", "Nikitevich", "Nikonovic", "Andronikovich", "Agapovich", "Iraklievich", "Igorevich", "Tarasovich", "Klimentovych", "Andronikovich", "Moiseevich", "Semenovich", "Olegovych", "Nestorovich", "Kazimirovich", "Adrianovich", "Zinovievich", "Socratovich" };
            connection = new SqlConnection(@"Data Source = VALENTINE\SQLEXPRESS; Initial Catalog = Kpi2; Integrated Security = True");
            connection.Open();
            string queryString =
                "IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'Complaints' AND xtype = 'U')" +
                "DROP TABLE [Complaints];" +
                "IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME = 'Clients' AND xtype = 'U')" +
                "DROP TABLE [Clients];" +

                "CREATE TABLE[Clients](" +
                "[ClientID] INT IDENTITY(1,1) NOT NULL," +
                "[FirstName] NVARCHAR(255) NOT NULL," +
                "[LastName] NVARCHAR(255) NOT NULL," +
                "[MiddleName] NVARCHAR(255)NOT NULL," +
                "CONSTRAINT PK_ClientID PRIMARY KEY CLUSTERED(ClientID))" +

                "CREATE TABLE [Complaints] (" +
                "[ComplaintID] INT IDENTITY(1,1) NOT NULL," +
                "[Price] NVARCHAR(255) NOT NULL," +
                "[ClientID] INT NOT NULL," +
                "CONSTRAINT FK_ClientID FOREIGN KEY(ClientID) REFERENCES[Clients]([ClientID])," +
                "CONSTRAINT PK_ComplaintID PRIMARY KEY CLUSTERED(ComplaintID))";
            SqlCommand command = new SqlCommand(queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        private void buttonClearTable_Click(object sender, EventArgs e)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            connection.Open();
            string queryString =
                "TRUNCATE TABLE [Complaints] " +
                "ALTER TABLE [Complaints] " +
                "DROP CONSTRAINT FK_ClientID " +
                "TRUNCATE TABLE [Clients]" +
                "ALTER TABLE [Complaints] " +
                "ADD CONSTRAINT FK_ClientID FOREIGN KEY(ClientID) REFERENCES[Clients]([ClientID])";
            SqlCommand command = new SqlCommand(queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();

            stopWatch.Stop();
            timeClear.Text = (stopWatch.ElapsedMilliseconds / 1000.0).ToString() + "s";
        }

        private void buttonFillTable_Click(object sender, EventArgs e)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            connection.Open();

            int rowCount = Convert.ToInt32(CountRows.Text);

            Random random = new Random();

            DataTable table1 = new DataTable();
            table1.Columns.Add("ClientID", typeof(int));
            table1.Columns.Add("FirstName", typeof(string));
            table1.Columns.Add("LastName", typeof(string));
            table1.Columns.Add("MiddleName", typeof(string));

            for (int i = 0; i < rowCount; i++)
                table1.Rows.Add(new object[] {
                            i + 1,
                            FirstNames[random.Next(0, 99)],
                            LastNames[random.Next(0, 99)],
                            MiddleNames[random.Next(0, 99)] });

            SqlBulkCopy bulkCopy1 = new SqlBulkCopy(connection);
            bulkCopy1.DestinationTableName = "[Clients]";
            bulkCopy1.WriteToServer(table1);

            connection.Close();

            connection.Open();

            DataTable table2 = new DataTable();
            table2.Columns.Add("ComplaintID", typeof(int));
            table2.Columns.Add("Price", typeof(string));
            table2.Columns.Add("ClientID", typeof(int));

            for (int i = 0; i < rowCount; i++)
                table2.Rows.Add(new object[] {
                            i + 1,
                            ((10 * random.Next(0, 1000)).ToString() + "$"),
                            random.Next(1, rowCount) });

            SqlBulkCopy bulkCopy2 = new SqlBulkCopy(connection);
            bulkCopy2.DestinationTableName = "[Complaints]";
            bulkCopy2.WriteToServer(table2);

            connection.Close();

            stopWatch.Stop();
            timeFill.Text = (stopWatch.ElapsedMilliseconds / 1000.0).ToString() + "s";
        }

        private void buttonExecuteQuery_Click(object sender, EventArgs e)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            connection.Open();
            string queryString =
                "SELECT [FirstName]," +
                "[LastName]," +
                "[MiddleName]" +
                "[Price]" +
                "FROM [Complaints] AS [CO]" +
                "JOIN [Clients] AS [CL]" +
                "    ON CO.ClientID = CL.ClientID " +
                "WHERE [Price] = '1000$'";
            SqlCommand command = new SqlCommand(queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();

            stopWatch.Stop();
            timeExecute.Text = (stopWatch.ElapsedMilliseconds / 1000.0).ToString() + "s";
        }

        private void buttonCreateIndex_Click(object sender, EventArgs e)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            connection.Open();
            string queryString =
                "IF NOT EXISTS(SELECT * FROM sysindexes WHERE name = 'Index1')" +
                "CREATE NONCLUSTERED INDEX Index1 ON [Complaints]([Price])";
            SqlCommand command = new SqlCommand(queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();

            stopWatch.Stop();
            timeCreate.Text = (stopWatch.ElapsedMilliseconds / 1000.0).ToString() + "s";
        }

        private void buttonDeleteIndex_Click(object sender, EventArgs e)
        {
            connection.Open();
            string queryString =
                "IF EXISTS(SELECT * FROM sysindexes WHERE name = 'Index1')" +
                "DROP INDEX [Index1] ON [dbo].[Complaints]";
            SqlCommand command = new SqlCommand(queryString, connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            connection.Dispose();
        }
    }
}
