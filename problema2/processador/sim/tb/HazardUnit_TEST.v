module HazardUnit_TEST();

reg [4:0] IDRegRs,IDRegRt,EXRegRt;
wire PCWrite, IFIDWrite, HazMuxCon;
reg ExpectedPCWrite, ExpectedIFIDWrite, ExpectedHazMuxCon;

HazardUnit HazardUnit_1(
	.IDRegRs(IDRegRs),
	.IDRegRt(IDRegRt),
	.EXRegRt(EXRegRt),
	.EXMemRead(EXMemRead),

	.PCWrite(PCWrite),
	.IFIDWrite(IFIDWrite),
	.HazMuxCon(HazMuxCon)
);


integer i;
localparam loops = 10; // number of times to run the tests for


	// Testing logic:
    initial begin
        for(i = 0; i < loops; i = i + 1)
        begin
        	IDRegRs = {$random} % 5'b10000;
        	IDRegRt = {$random} % 5'b10000;
        	EXRegRt = {$random} % 5'b10000;

            #10

        	$display("------------------------------");
       		$display("ExpectedValues:");
        	$display("------------------------------");

        	expectedValues;
        	checkout;
        end

        for(i = 0; i < loops; i = i + 1)
        begin
        	IDRegRs = {$random} % 5'b10000;
        	IDRegRt = {$random} % 5'b10000;
        	EXRegRt = {$random} % 5'b10000;

            #10
            
        	$display("------------------------------");
       		$display("WrongdValues:");
        	$display("------------------------------");

        	wrongValues;
        	checkout;
        end
	
end

task expectedValues;
	begin
		if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt)))
 		begin
 			ExpectedPCWrite = 0;
 			ExpectedIFIDWrite = 0;
 			ExpectedHazMuxCon = 1;
	 	end
		else
 		begin
 			ExpectedPCWrite = 1;
 			ExpectedIFIDWrite = 1;
 			ExpectedHazMuxCon = 0;
 		end
	end
endtask

task wrongValues;
	begin
		if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt)))
 		begin
 			ExpectedPCWrite = 1;
 			ExpectedIFIDWrite = 1;
 			ExpectedHazMuxCon = 0;
	 	end
		else
 		begin
 			ExpectedPCWrite = 0;
 			ExpectedIFIDWrite = 0;
 			ExpectedHazMuxCon = 1;
 		end
	end
endtask

task checkout;
	begin
		if (PCWrite == ExpectedPCWrite) $display("PCWrite OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedPCWrite, PCWrite);
        else begin
                $display("PCWrite ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedPCWrite, PCWrite);
        end 
		if (IFIDWrite == ExpectedIFIDWrite) $display("PCWrite OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedIFIDWrite, IFIDWrite);
        else begin
                $display("PCWrite ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedIFIDWrite, IFIDWrite);
        end 
		if (HazMuxCon == ExpectedHazMuxCon) $display("PCWrite OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedHazMuxCon, HazMuxCon);
        else begin
                $display("PCWrite ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedHazMuxCon, HazMuxCon);
        end 

	end
endtask
endmodule