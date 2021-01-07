#include "isim/work/full_add/behavioral.h"
static const char * HSimCopyRightNotice = "Copyright 2004-2005, Xilinx Inc. All rights reserved.";
#include "E:/Xilinx/vhdl/hdp/nt/ieee/std_logic_1164/std_logic_1164.h"
#include "E:/Xilinx/vhdl/hdp/nt/ieee/std_logic_arith/std_logic_arith.h"
#include "E:/Xilinx/vhdl/hdp/nt/ieee/std_logic_unsigned/std_logic_unsigned.h"

class _top : public HSim__s6 {
public:
    _top() : HSim__s6(false, "_top", "_top", 0, 0, HSim::VhdlDesignEntity) {}
    HSimConfigDecl * topModuleInstantiate() {
        HSimConfigDecl * cfgvh = 0;
        cfgvh = new HSimConfigDecl("default");
        HSim__s6 * topvh = 0;
        topvh = new Work_full_add_behavioral("full_add");
        topvh->constructPorts();
        topvh->vhdlArchImplement();
        topvh->architectureInstantiate(cfgvh);
        addChild(topvh);
        return cfgvh;
}
};

main(int argc, char **argv) {
  HSimDesign::initDesign();
  globalKernel->getOptions(argc,argv);
  HSim__s6 * _top_i = 0;
  try {
    IeeeStd_logic_1164=new Ieee_std_logic_1164("Std_logic_1164");
    IeeeStd_logic_arith=new Ieee_std_logic_arith("Std_logic_arith");
    IeeeStd_logic_unsigned=new Ieee_std_logic_unsigned("Std_logic_unsigned");
    HSimConfigDecl *cfg;
 _top_i = new _top();
  cfg =  _top_i->topModuleInstantiate();
    return globalKernel->runTcl(cfg, _top_i, "_top", argc, argv);
  }
  catch (HSimError& msg){
    try {
      globalKernel->error(msg.ErrMsg);
      return 1;
    }
    catch(...) {}
      return 1;
  }
  catch (...){
    globalKernel->fatalError();
    return 1;
  }
}
