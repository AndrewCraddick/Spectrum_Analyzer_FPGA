`timescale 1ns / 1ps

module Spectrum_Analyzer_top_tb(

    );
    
reg clock;    
// ----- slave connections ---------------------------    
wire [63:0] s_axis_phase_tdata;
wire        s_axis_phase_tvalid;        
wire        s_axis_phase_tready;        
// ------ master connections --------------------------
wire [7:0]  m_axis_data_tdata;
wire [31:0] m_axis_phase_tdata;
wire        m_axis_data_tvalid;
wire        m_axis_data_tready;
wire        m_axis_phase_tvalid;
wire        m_axis_phase_tready;
// ----------------------------------------------------

wire [4:0] state_reg_of_Phase_Accumulator_Control_module;
reg reset;
assign s_axis_phase_tready = 1;
initial  begin
    
    clock = 0;
    reset = 1;
    #5 reset = 0;
    forever #5 clock = ~clock;
      
end


   
    
    
dds_compiler_0 dds_compiler_wiz (         
  .aclk(clock),                              // input  wire aclk                       
  .s_axis_phase_tvalid(s_axis_phase_tvalid), // input  wire s_axis_phase_tvalid        
  .s_axis_phase_tready(s_axis_phase_tready), // output wire s_axis_phase_tready       
  .s_axis_phase_tdata(s_axis_phase_tdata),   // input  wire [63 : 0] s_axis_phase_tdata, gives current phawe value of accumulator
  .m_axis_data_tvalid(m_axis_data_tvalid),   // output wire m_axis_data_tvalid        
  .m_axis_data_tready(m_axis_data_tready),   // input  wire m_axis_data_tready         
  .m_axis_data_tdata(m_axis_data_tdata),     // output wire [7 : 0] m_axis_data_tdata 
  .m_axis_phase_tvalid(m_axis_phase_tvalid), // output wire m_axis_phase_tvalid       
  .m_axis_phase_tready(m_axis_phase_tready), // input  wire m_axis_phase_tready        
  .m_axis_phase_tdata(m_axis_phase_tdata)    // output wire [31 : 0] m_axis_phase_tdata
);               


Phase_Accumulator_Control Phase_Accumulator_Control_inst(                                      
  .clock(clock),                                                       
  .reset(reset),                                                       
  .s_axis_phase_tready(s_axis_phase_tready),                                         
  .s_axis_phase_tvalid(s_axis_phase_tvalid),  // phase data valid to be sent     
  .s_axis_phase_tdata(s_axis_phase_tdata),    // [63:0] reg, 0-31 gives current_phase_incr_size                           
  .m_axis_phase_tready(m_axis_phase_tready),  // phase data ready to receive     
  .m_axis_data_tready(m_axis_data_tready),    // sine wave data ready to receive  
  .state_reg_of_Phase_Accumulator_Control_module(state_reg_of_Phase_Accumulator_Control_module) // [4:0]reg that defines the current state of the FSM
);      
    
    
endmodule

    

