         ctl-opt dftactgrp(*no) alloc(*teraspace) stgmdl(*teraspace)
                 actgrp('MYCALL');
      //------------------------------------------------------------------//
      //                                                                  //
      // Test - Call from Node.js                                         //
      //                                                                  //
      //-----------------                                                 //
      // R.Ross 07.2022 *                                                 //
      //------------------------------------------------------------------//
      // Parameter                                                        //
      //------------------------------------------------------------------//

         dcl-pi *n;
                 PiData      varchar(16000000) const ccsid(*utf8);
         end-pi;

      //------------------------------------------------------------------//
      // SQL-Options                                                      //
      //------------------------------------------------------------------//

         exec sql set option datfmt=*iso, timfmt=*iso, commit=*none,
                             decmpt=*period, closqlcsr=*endactgrp;

      //------------------------------------------------------------------//
      // QCMDEXC                                                          //
      //------------------------------------------------------------------//

         dcl-pr QCMDEXC      extpgm;
                 Command     char(256)    const options(*varsize);
                 Length      packed(15:5) const;
         end-pr;

         dcl-s   GblCommand  varchar(256);

      //------------------------------------------------------------------//
      // Data                                                             //
      //------------------------------------------------------------------//

         dcl-ds  DsData      qualified inz;
                  Program    char(10);
                  Library    char(10);
         end-ds;

      //------------------------------------------------------------------//
      // Processing                                                       //
      //------------------------------------------------------------------//

         main();

         return;
      //------------------------------------------------------------------//
      // Main                                                             //
      //------------------------------------------------------------------//
         dcl-proc main;

         dcl-s   LocJson     sqltype(CLOB:16000000) ccsid(*utf8);
         dcl-s   LocStart    timestamp;
         dcl-s   LocRuntime  packed(9:4);

           LocStart = %timestamp;

           clear LocJson;

           LocJson_data = PiData;
           LocJson_len  = %len(PiData);

           if LocJson_len = *zero;                    // no data -> return
              return;
           endif;

           exec sql
            set TSTO.MYJSONDATA = :LocJson;           // Data -> SQL Variable

           clear DsData;

           exec sql                                   // Parse JSON data
            select *
              into :DsData
              from JSON_TABLE(:LocJson, '$'
               Columns(
                Program  char(10) path '$.program' default '' on empty,
                Library  char(10) path '$.library' default '' on empty
               )
              );

           LocRuntime = %diff(%timestamp:locStart:*ms) / 1000000;

           exec sql                                   // write data to MYLOG00
            insert into TSTO.MYLOG00 values (
              current_timestamp, current_user, :LocRuntime, :LocJson
            ) with nc;


           if DsData.Library <> *blanks and DsData.Program <> *blanks;
              callProgram(DsData);
           endif;

         end-proc;
      //------------------------------------------------------------------//
      // Call Program                                                     //
      //------------------------------------------------------------------//
         dcl-proc callProgram;
         dcl-pi *n;
                 PiData      likeds(DsData) const;
         end-pi;

         dcl-s   LocCommand  like(GblCommand);
         dcl-s   LocString   varchar(128);
         dcl-s   LocLength   uns(10);

           LocString  =  %trim(PiData.Library) + '/' + %trim(PiData.Program);

           LocCommand = 'CALL PGM(' + %upper(LocString) + ')';
           LocLength  = %len(LocCommand);

           monitor;
             QCMDEXC(LocCommand:LocLength);
            on-error;
           endmon;

         end-proc;
      //------------------------------------------------------------------// 
