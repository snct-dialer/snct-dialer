/*
 * Example to connect to MariaDB(MySQL)
 */
#include <iostream>
#include <mariadb/mysql.h>
#include <string>
#include <array>
#include <cstring>
#include <exception>
#include <time.h>
#include <syslog.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <syslog.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#define DAEMON_NAME "GenRTD"

#include "ConfigFile.h"

#define SLIVE_STATION  1
#define SLIVE_PHONE    2
#define SLIVE_USER     3
#define SLIVE_USERNAME 4
#define SLIVE_SERVERIP 11

#define VUSER_USER       1
#define VUSER_FULL_NAME  3
#define VUSER_USER_GROUP 5

#define PHONE_LOGIN			6

using namespace std;

/*
 * [CLASS] Process
 */
class Proc {

	std::string MY_HOSTNAME;
	std::string MY_DATABASE;
	std::string MY_USERNAME;
	std::string MY_PASSWORD;
	const char *MY_SOCKET;
	enum {
		MY_PORT_NO = 3306,
		MY_OPT = 0
	};
	const char *TableNameRTV = "snctdialer_live";
	MYSQL     *conn;
	MYSQL_RES *res;
//	MYSQL_ROW row;

public:
	Proc();           // Constructor
	bool execMain();  // Main Process

private:
	std::string		 strPauseStatus;
	
	std::string GetCustPhone(long);
	array<string,2> GetInbound(char *);
	std::string GetPauseStatus(char *, int, bool);
	bool CheckPauseReq();
	std::string formatZeit(double);
	void FillUserPhones(void);
};


void Proc::FillUserPhones(void) {

	char 		sql7[256];
	char 		sql8[256];
	char 		sql9[256];
	char 		sql22[512];
	char 		FullName[100];
	char 		UserGrp[50];
	char 		APhone[50];
	char *		Ext;
	char 		Proto[50];
	char 		Extention[50];

	MYSQL_ROW 	row4, row51, row6;
	MYSQL_RES *res51, *res6;

	try {
	snprintf(sql7, sizeof(sql7),"SELECT * FROM `%s` WHERE `UserName` = '' OR `Phone` = '';" , TableNameRTV);
	if (mysql_query(conn, sql7)) {
		cerr << mysql_error(conn) << endl;
	}
//	cout << sql << endl;
	MYSQL_RES *res42 = mysql_store_result(conn);
	if(mysql_num_rows(res42) > 0) {
		while ((row4 = mysql_fetch_row(res42)) != NULL) {
//			cout << "Begin " << endl;
			if (strlen(row4[SLIVE_PHONE]) == 0) {
				Ext = row4[SLIVE_STATION];
				char * pch;
				pch = strtok (Ext,"/");
				int i = 0;
				while (pch != NULL) {
					if(i == 1) {
						strcpy(Extention, pch);
						i++;
					}
					if(i == 0) {
						strcpy(Proto, pch);;
						i++;
					}
					pch = strtok (NULL, "/");
				}
				if(strcmp(Proto, "R") == 0) {
					strcpy(Proto,"EXTERNAL");
				}
				snprintf(sql8, sizeof(sql8), "SELECT login from phones where server_ip='%s' and extension = '%s' and protocol='%s';", row4[SLIVE_SERVERIP], Extention, Proto);
				if (mysql_query(conn, sql8)) {
					cerr << mysql_error(conn) << endl;
				}
//				cout << sql8 << endl;
				res51 = mysql_store_result(conn);
				if(mysql_num_rows(res51) > 0) {
//					cout << "Begin 1" << endl;
					row51 = mysql_fetch_row(res51);
					strcpy(APhone,row51[0]);
//					cout << "Erg: " << row51[0] << "|" << row51[1] << endl;
				}
				mysql_free_result(res51);
			}
			if (strlen(row4[SLIVE_USERNAME]) == 0) {
				snprintf(sql9, sizeof(sql9), "SELECT * FROM `vicidial_users` WHERE `user` = '%s';" , row4[SLIVE_USER]);
				if (mysql_query(conn, sql9)) {
					cerr << mysql_error(conn) << endl;
				}
//				cout << sql9 << endl;
				res6 = mysql_store_result(conn);
				if(mysql_num_rows(res6) > 0) {
					cout << "Begin 2" << endl;
					row6 = mysql_fetch_row(res6);
					strcpy(FullName, row6[VUSER_FULL_NAME]);
					strcpy(UserGrp, row6[VUSER_USER_GROUP]);
				}
				mysql_free_result(res6);
			}
//			cout << APhone << "| ";
			snprintf(sql22, sizeof(sql22), "UPDATE `%s` SET `Phone` = '%s', `UserName` = '%s', `UserGrp` = '%s'  WHERE `User` = '%s';", TableNameRTV, APhone, FullName, UserGrp, row4[SLIVE_USER]);
//			cout << sql22 << endl;
			if (mysql_query(conn, sql22)) {
				cerr << mysql_error(conn) << endl;
			}
		}
	}
//	mysql_free_result(res51);
//	mysql_free_result(res6);
	mysql_free_result(res42);
	} catch (char *e) {
		cerr << "Func FillUserPhones: [EXCEPTION] " << e << endl;
		return;
	}
}

std::string Proc::formatZeit(double Sek) {
	std::string			strRet = "";

	int days  = ((int)Sek / (60 * 60 * 24));
	int iSek  = (int)Sek % (60 * 60 * 24);
	int ihours = iSek / (60 * 60);
	iSek  = iSek % (60 * 60);
	int imins  = iSek / 60;
	iSek  = iSek % 60;
	
	char chRet[10];
	sprintf(chRet, "%0.2d:%0.2d:%0.2d", ihours, imins, iSek);
	return chRet;
}

bool Proc::CheckPauseReq() {
	bool 		bRet;

	bRet = false;
	char *sql6 = (char *)"SELECT count(*) from vicidial_campaigns where agent_pause_codes_active != 'N';";
	if (mysql_query(conn, sql6)) {
		cerr << mysql_error(conn) << endl;
	}
	MYSQL_RES *res41 = mysql_store_result(conn);
	MYSQL_ROW row41 = mysql_fetch_row(res41);
	if(row41[0] > 0 ) {
		bRet = true;
	} 
	mysql_free_result(res41);
	return bRet;
}

std::string Proc::GetPauseStatus(char *chUser, int AgentLogID, bool bPauseStatusEnabled) {
	std::string 		strRet = "";
	char 				sql5[512];
	
	try {
		if(bPauseStatusEnabled == true) {
			snprintf(sql5, sizeof(sql5),"SELECT `sub_status` from `vicidial_agent_log` where `agent_log_id` >= '%d' and `user`='%s' order by `agent_log_id` desc limit 1;", AgentLogID, chUser);
			if (mysql_query(conn, sql5)) {
				cerr << mysql_error(conn) << endl;
			}
//			cout << "SQL5: " << sql5 << endl;
			MYSQL_RES *res3 = mysql_store_result(conn);
			if(mysql_num_rows(res3) > 0) {
				MYSQL_ROW row3 = mysql_fetch_row(res3);
				if (row3[0] != NULL) {
//					cout << ">|" << row3[0] << "|<" << endl;
					strRet = row3[0];
				}
			} 
			mysql_free_result(res3);
		}
	} catch (char *e) {
		cerr << "Func GetPauseStatus: [EXCEPTION] " << e << endl;
		return strRet;
	}
//	cout << "|" << strRet << endl;
	return strRet;
}

array<string, 2> Proc::GetInbound(char *chCallerID) {
	static array<string, 2>			arrRet;

	try {
		arrRet[0] = "";
		arrRet[1] = "";
		char sql4[255];
		snprintf(sql4, sizeof(sql4),"SELECT vac.campaign_id,vac.stage,vig.group_name,vig.group_id from vicidial_auto_calls vac,vicidial_inbound_groups vig where vac.callerid='%s' and vac.campaign_id=vig.group_id LIMIT 1;", chCallerID);

		if (mysql_query(conn, sql4)) {
			cerr << mysql_error(conn) << endl;
		}
		MYSQL_RES *res2 = mysql_store_result(conn);
		if(mysql_num_rows(res2) > 0) {
			MYSQL_ROW row2 = mysql_fetch_row(res2);
			char * chTmp = row2[1];
			
			char *pch = strtok (chTmp,"-");
			int i = 0;
			while (pch != NULL) {
				if(i == 1) {
					arrRet[0] = pch;
					i++;
				}
				if(i == 0) {
					i++;
				}
				pch = strtok (NULL, "-");
			}
			
			
			arrRet[1] = row2[0];
//			arrRet[0] = row2[1];
		}

		mysql_free_result(res2);
		return arrRet;
	} catch (char *e) {
		cerr << "Func GetInbound: [EXCEPTION] " << e << endl;
		return arrRet;
	}
	
}


std::string Proc::GetCustPhone(long lLeadID) {
	std::string			strRet;
	
	try {
	strRet = "";
	char sql3[255];
	snprintf(sql3, sizeof(sql3), "SELECT callerid,lead_id,phone_number, phone_code from `vicidial_auto_calls` WHERE `lead_id` = '%ld';", lLeadID);
	
	if (mysql_query(conn, sql3)) {
		cerr << mysql_error(conn) << endl;
		strRet= "";
	}
	MYSQL_RES *res1 = mysql_store_result(conn);
	if(mysql_num_rows(res1) > 0) {
		MYSQL_ROW row1 = mysql_fetch_row(res1);
		strRet = "+";
		strRet.append(row1[3]);
		strRet.append(row1[2]);
	} else {
		strRet = "";
	}

	mysql_free_result(res1);
	return strRet;
	}  catch (char *e) {
		cerr << "Func GetCustPhone: [EXCEPTION] " << e << endl;
		return "";
	}
}
/*
 * Proc - Constructor
 */
Proc::Proc()
{
	ConfigFile cf("/etc/snct-dialer/snct-dialer.conf");


    // Initialize constants
/*    MY_HOSTNAME = "10.100.0.17";
    MY_DATABASE = "asterisk_snct";
    MY_USERNAME = "cron";
    MY_PASSWORD = "v1c1d1SNCT";
    MY_SOCKET   = NULL;
*/
    cout << MY_HOSTNAME << "|" << MY_DATABASE << "|"<< MY_USERNAME << "|"<< MY_PASSWORD << endl;
    
    MY_HOSTNAME = (string)cf.Value("Database","VARDB_server");
    MY_DATABASE = (string)cf.Value("Database","VARDB_database");
    MY_USERNAME = (string)cf.Value("Database","VARDB_user");
    MY_PASSWORD = (string)cf.Value("Database","VARDB_pass");
    MY_SOCKET   = NULL;

    cout << MY_HOSTNAME << "|" << MY_DATABASE << "|"<< MY_USERNAME << "|"<< MY_PASSWORD << endl;   
}

/*
 * Main Process
 */
bool Proc::execMain() {
	
	try {
	while(1) {
		double time1=0.0, tstart;
		tstart = clock(); 
		int iCount = 0;
		try {
			conn = mysql_init(NULL);

			if (!mysql_real_connect(
					conn,
					MY_HOSTNAME.c_str(), MY_USERNAME.c_str(),
					MY_PASSWORD.c_str(), MY_DATABASE.c_str(),
					MY_PORT_NO, MY_SOCKET, MY_OPT)) {
				cerr << mysql_error(conn) << endl;
				return false;
			}
			char sqlE[128];

			snprintf(sqlE, sizeof(sqlE), "START TRANSACTION;");
			if (mysql_query(conn, sqlE)) {
				cerr << mysql_error(conn) << endl;
			}
			
			snprintf(sqlE, sizeof(sqlE), "UPDATE `%s` SET `invalid` = 1;", TableNameRTV);
			if (mysql_query(conn, sqlE)) {
				cerr << mysql_error(conn) << endl;
			}

			if (mysql_query(conn, "SELECT * FROM `vicidial_live_agents`;")) {
				cerr << mysql_error(conn) << endl;
				return false;
			}
			
			res = mysql_store_result(conn);
			
			bool 				bPauseStat = CheckPauseReq();
			std::string 		strPauseStatus;
			struct tm  			ttFirstTime, tmLastState, tmLastCall;
			MYSQL_ROW 			row;
			while ((row = mysql_fetch_row(res)) != NULL) {
				int 				iStatSort = 0;
				char 				chSubSt[10] = "";
//				char				strPauseStatus[20] = "";
				array<string, 2>	arrList;

				iCount++;
				std::string PhoneNr = GetCustPhone(atol(row[6]));

				strptime(row[34], "%Y-%m-%d %H:%M:%S", &tmLastState);
				strptime(row[12], "%Y-%m-%d %H:%M:%S", &tmLastCall);
				
				ttFirstTime = tmLastState;

//				cout << row[34] << "|" << row[12] << "|" << row[1]<< endl;
				
				if((strlen(row[6]) > 1)  && (PhoneNr.length() == 0)) {
					strcpy(row[5],"DEAD");
					iStatSort = 4;
					ttFirstTime = tmLastState;
				} else {
				if(strcmp(row[5], "DIAL") == 0) {
					ttFirstTime = tmLastCall;
					iStatSort = 6;
				}
				if(strcmp(row[5], "QUEUE") == 0) {
					ttFirstTime = tmLastCall;
					iStatSort = 7;
				}
				if(strcmp(row[5], "PARK") == 0) {
					ttFirstTime = tmLastCall;
					iStatSort = 8;
				}
				if(strcmp(row[5], "READY") == 0) {
					iStatSort = 10;
				}
				if(strcmp(row[5], "CLOSER") == 0) {
					iStatSort = 9;
				}
				if(strcmp(row[5], "3-WAY") == 0) {
					iStatSort = 8;
				}
				if(strcmp(row[5], "PAUSED") == 0) {
//					cout << row[1] << "|" << row[5] << endl;
					iStatSort = 2;
					if(bPauseStat == true) {
						strPauseStatus = GetPauseStatus(row[1], atoi(row[33]), bPauseStat);
					}
				}
				if(strcmp(row[5], "INCALL") == 0) {
					ttFirstTime = tmLastState;
					iStatSort = 8;
					if(strcmp(row[18], "MANUAL") == 0) {
						strcpy(chSubSt,"M");
					}
					if(strcmp(row[18], "AUTO") == 0) {
						strcpy(chSubSt,"A");
					}
					if(strcmp(row[18], "INBOUND") == 0) {
						strcpy(chSubSt, "I");
						arrList = GetInbound(row[9]);
					}
				}
				}
				time_t ttnow = time(NULL);
				std:string strTime = formatZeit(difftime(ttnow,mktime(&ttFirstTime)));
				char sql2[8196];

				snprintf(sql2, sizeof(sql2), "INSERT IGNORE INTO `%s` SET `Station` = '%s', `Phone` = '', `User` = '%s', `UserGrp` = '' , `SessionID` = '%s', `Status` = '%s', "
						" `SubStatus` = '%s', `CustomPhone` = '%s', `ServerIP` = '%s', `CallServerIP` = '%s', `Time` = '%s', `Campaign` = '%s', `Calls` = '%s', `Pause` = '%s', `Hold` = '%s',"
						" `Ingroup` = '%s', `invalid` = 0, `SortStatus` = '%d'  ON DUPLICATE KEY UPDATE  `Station` = '%s',`Pause` = '%s', `Time` = '%s', `SessionID` = '%s', `Status` = '%s',"
						" `SubStatus` = '%s', `CustomPhone` = '%s', `ServerIP` = '%s', `CallServerIP` = '%s', `Campaign` = '%s', `Calls` = '%s', `Hold` = '%s', `Ingroup` = '%s', `invalid` = 0,"
						" `SortStatus` = '%d';",
					TableNameRTV, 
					row[4], 
					row[1],
					row[3],
					row[5],
					chSubSt,
					PhoneNr.c_str(),
					row[2],
					row[16],
					strTime.c_str(), 
					row[7],
					row[20],
					strPauseStatus.c_str(),
					arrList[0].c_str(),
					arrList[1].c_str(),
					iStatSort,
					row[4],
					strPauseStatus.c_str(),
					strTime.c_str(),
					row[3],
					row[5],
					chSubSt,
					PhoneNr.c_str(),
					row[2],
					row[16],
					row[7],
					row[20],
					arrList[0].c_str(),
					arrList[1].c_str(),
					iStatSort);

//				syslog(LOG_INFO, sql2);
				if (mysql_query(conn, sql2)) {
					cerr << mysql_error(conn) << endl;
				}
			}

			FillUserPhones();

			char sqlEx[128];
			snprintf(sqlEx, sizeof(sqlEx), "DELETE FROM `%s` WHERE `invalid` = 1;", TableNameRTV);
			if (mysql_query(conn, sqlEx)) {
				cerr << mysql_error(conn) << endl;
			}

			snprintf(sqlE, sizeof(sqlE), "COMMIT;");
			if (mysql_query(conn, sqlE)) {
				cerr << mysql_error(conn) << endl;
			}
			mysql_free_result(res);
			mysql_close(conn);
		} catch (char *e) {
			cerr << "Func Main: [EXCEPTION] " << e << endl;
			return false;
		}
		try {
			time1 += clock() - tstart;
			time1 = time1/CLOCKS_PER_SEC;
			char chLog[255];
			sprintf(chLog, "Runtime : %lf sec. for %d agents", time1, iCount);
			syslog(LOG_INFO, chLog);
			usleep(500000);
		} catch (char *e) {
			cerr << "Func Main Timer: [EXCEPTION] " << e << endl;
			return false;
		}
	}
	return true;
	} 
	catch (char *e) {
		cerr << "Func Main End: [EXCEPTION] " << e << endl;
		return false;
	}
}


void daemonShutdown();
void signal_handler(int sig);
void daemonize(const char *rundir, const char *pidfile);

bool exitdaemon = false;
int pidFilehandle;


void signal_handler(int sig)
{
    switch(sig)
    {
        case SIGINT:
        case SIGTERM:
            exitdaemon = true;
            break;
    }
}

void daemonShutdown()
{
    syslog(LOG_INFO, "Daemon exiting");
    close(pidFilehandle);
}

void daemonize(const char *rundir, const char *pidfile)
{
    int pid, sid, i;
    char str[10];
    struct sigaction newSigAction;
    sigset_t newSigSet;

    /* Check if parent process id is set */
    if (getppid() == 1)
    {
        /* PPID exists, therefore we are already a daemon */
        return;
    }

    /* Set signal mask - signals we want to block */
    sigemptyset(&newSigSet);
    sigaddset(&newSigSet, SIGCHLD);  /* ignore child - i.e. we don't need to wait for it */
    sigaddset(&newSigSet, SIGTSTP);  /* ignore Tty stop signals */
    sigaddset(&newSigSet, SIGTTOU);  /* ignore Tty background writes */
    sigaddset(&newSigSet, SIGTTIN);  /* ignore Tty background reads */
    sigprocmask(SIG_BLOCK, &newSigSet, NULL);   /* Block the above specified signals */

    /* Set up a signal handler */
    newSigAction.sa_handler = signal_handler;
    sigemptyset(&newSigAction.sa_mask);
    newSigAction.sa_flags = 0;

    /* Signals to handle */
    sigaction(SIGHUP, &newSigAction, NULL);     /* catch hangup signal */
    sigaction(SIGTERM, &newSigAction, NULL);    /* catch term signal */
    sigaction(SIGINT, &newSigAction, NULL);     /* catch interrupt signal */


    /* Fork*/
    pid = fork();

    if (pid < 0)
    {
        /* Could not fork */
        exit(EXIT_FAILURE);
    }

    if (pid > 0)
    {
        /* Child created ok, so exit parent process */
        //printf("Child process created: %d\n", pid);
        exit(EXIT_SUCCESS);
    }

    /* Child continues */

    umask(027); /* Set file permissions 750 */

    /* Get a new process group */
    sid = setsid();

    if (sid < 0)
    {
        exit(EXIT_FAILURE);
    }

    /* close all descriptors */
    for (i = getdtablesize(); i >= 0; --i)
    {
        close(i);
    }

    /* Route I/O connections */

    /* Open STDIN */
    i = open("/dev/null", O_RDWR);

    /* STDOUT */
    dup(i);

    /* STDERR */
    dup(i);

    chdir(rundir); /* change running directory */

    /* Ensure only one copy */
    pidFilehandle = open(pidfile, O_RDWR|O_CREAT, 0600);

    if (pidFilehandle == -1 )
    {
        /* Couldn't open lock file */
        syslog(LOG_INFO, "Could not open PID lock file %s, exiting", pidfile);
        exit(EXIT_FAILURE);
    }

    /* Try to lock file */
    if (lockf(pidFilehandle,F_TLOCK,0) == -1)
    {
        /* Couldn't get lock on lock file */
        syslog(LOG_INFO, "Could not lock PID lock file %s, exiting", pidfile);
        exit(EXIT_FAILURE);
    }


    /* Get and format PID */
    sprintf(str,"%d\n",getpid());

    /* write pid to lockfile */
    write(pidFilehandle, str, strlen(str));
}

int main()
{

    /* Logging */
    setlogmask(LOG_UPTO(LOG_INFO));
    openlog(DAEMON_NAME, LOG_CONS | LOG_PERROR, LOG_USER);

    syslog(LOG_INFO, "Daemon starting up");

    /* Deamonize */
    const char* daemonpid = "/var/run/GenRTD.pid";
    const char* daemonpath = "/";
    daemonize(daemonpath, daemonpid);

    syslog(LOG_INFO, "Daemon running");

    while (!exitdaemon)
    {
    	try {
    		Proc objMain;
    		bool bRet = objMain.execMain();
    		if (!bRet) cout << "ERROR!" << endl;
    	} catch (char *e) {
    		cerr << "MainStart: [EXCEPTION] " << e << endl;
    		return 1;
    	}
    	return 0;
    //    syslog(LOG_INFO, "daemon says hello");

    }
    daemonShutdown();
}

