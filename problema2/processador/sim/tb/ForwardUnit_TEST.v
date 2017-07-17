module ForwardUnit_TEST();

 reg[4:0] MEMRegRd,WBRegRd,EXRegRs,EXRegRt;
 reg MEM_RegWrite, WB_RegWrite;
 wire [1:0] ForwardA, ForwardB;
 reg[1:0] ExpectedForwardA, ExpectedForwardB;

ForwardUnit ForwardUnit_1(
    .MEMRegRd(MEMRegRd),
    .WBRegRd(WBRegRd),
    .EXRegRs(EXRegRs),
    .EXRegRt(EXRegRt),
    .MEM_RegWrite(MEM_RegWrite),
    .WB_RegWrite(WB_RegWrite),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);


integer i;
localparam loops = 10; // number of times to run the tests for


	// Testing logic:
    initial begin
        for(i = 0; i < loops; i = i + 1)
        begin
            MEMRegRd = {$random} % 5'b10000;
            WBRegRd = {$random} % 5'b10000;
            EXRegRs = {$random} % 5'b10000;
            EXRegRt = {$random} % 5'b10000;
            MEM_RegWrite = {$random} % 1'b0;
            WB_RegWrite = {$random} % 1'b1;

             #10

            $display("------------------------------");
            $display("ExpectedValues:");
            $display("------------------------------");

            expectedValues;
            checkout;
        end

        for(i = 0; i < loops; i = i + 1)
        begin
            MEMRegRd = {$random} % 5'b10000;
            WBRegRd = {$random} % 5'b10000;
            EXRegRs = {$random} % 5'b10000;
            EXRegRt = {$random} % 5'b10000;
            MEM_RegWrite = {$random} % 1'b1;
            WB_RegWrite = {$random} % 1'b1;

             #10

            $display("------------------------------");
            $display("WrongValues:");
            $display("------------------------------");

            wrongValues;
            checkout;
        end


        // Forced inputs tests

        MEMRegRd = 1;
        WBRegRd = 1;
        EXRegRs = 1;
        MEM_RegWrite =  1;
        #10
        $display("------------------------------");
        $display("ExpectedValues:");
        $display("------------------------------");
        expectedValues;
        checkout;


        MEMRegRd = 0;
        WBRegRd = 1;
        EXRegRs = 1;
        EXRegRt = 0;
        MEM_RegWrite = 0;
        WB_RegWrite = 1;
        #10
        $display("------------------------------");
        $display("ExpectedValues:");
        $display("------------------------------");
        expectedValues;
        checkout;


        MEMRegRd = 0;
        WBRegRd = 1;
        EXRegRs = 1;
        EXRegRt = 1;
        MEM_RegWrite = 0;
        WB_RegWrite = 1;
        #10
        $display("------------------------------");
        $display("ExpectedValues:");
        $display("------------------------------");
        expectedValues;
        checkout;

        MEMRegRd = 1;
        WBRegRd = 1;
        EXRegRs = 1;
        EXRegRt = 0;
        MEM_RegWrite = 1;
        WB_RegWrite = 1;
        #10
        $display("------------------------------");
        $display("ExpectedValues:");
        $display("------------------------------");
        expectedValues;
        checkout;

	
end

task expectedValues;
	begin

        if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRs))
            ExpectedForwardA = 2'b10;
        else if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRs)&&(MEMRegRd != EXRegRs) )
            ExpectedForwardA = 2'b01;
        else
            ExpectedForwardA = 2'b00;

        if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRt)&&(MEMRegRd != EXRegRt) )
            ExpectedForwardB = 2'b01;
        else if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRt))
           ExpectedForwardB = 2'b10;
        else
            ExpectedForwardB = 2'b00;
		
	end
endtask

task wrongValues;
	begin

        if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRs))
            ExpectedForwardA = 2'b01;
        else if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRs)&&(MEMRegRd != EXRegRs) )
            ExpectedForwardA = 2'b10;
        else
            ExpectedForwardA = 2'b01;

        if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRt)&&(MEMRegRd != EXRegRt) )
            ExpectedForwardB = 2'b10;
        else if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRt))
            ExpectedForwardB = 2'b11;
        else
            ExpectedForwardB = 2'b01;
	end
endtask

task checkout;
	begin
    if (ForwardA == ExpectedForwardA) $display("ForwardA OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedForwardA, ForwardA);
        else begin
                $display("ForwardA ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedForwardA, ForwardA);
        end 
        if (ForwardB == ExpectedForwardB) $display("ForwardB OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedForwardB, ForwardB);
        else begin
                $display("ForwardB ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  ExpectedForwardB, ForwardB);
        end 
	end
endtask
endmodule