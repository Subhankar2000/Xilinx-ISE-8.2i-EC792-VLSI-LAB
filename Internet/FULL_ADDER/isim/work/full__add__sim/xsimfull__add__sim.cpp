#include "isim/work/full__add__sim/full__add__sim.h"
#include "isim/work/glbl/glbl.h"
static const char * HSimCopyRightNotice = "Copyright 2004-2005, Xilinx Inc. All rights reserved.";


#include "work/full__add__sim/full__add__sim.h"
static HSim__s6* IF0(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new workMfull__add__sim(label); 
    return blk;
}


#include "unisim_ver.auxlib/_a_n_d2/_a_n_d2.h"
static HSim__s6* IF1(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_a_n_d2(label); 
    return blk;
}


#include "unisim_ver.auxlib/_o_r2/_o_r2.h"
static HSim__s6* IF2(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_o_r2(label); 
    return blk;
}


#include "unisim_ver.auxlib/_x_o_r2/_x_o_r2.h"
static HSim__s6* IF3(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_x_o_r2(label); 
    return blk;
}


#include "unisim_ver.auxlib/_x_o_r2/_x_o_r2.h"
static HSim__s6* IF4(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_x_o_r2(label); 
    return blk;
}


#include "unisim_ver.auxlib/_o_r2/_o_r2.h"
static HSim__s6* IF5(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_o_r2(label); 
    return blk;
}


#include "unisim_ver.auxlib/_a_n_d2/_a_n_d2.h"
static HSim__s6* IF6(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new unisim_ver_auxlibM_a_n_d2(label); 
    return blk;
}


#include "work/full__add/full__add.h"
static HSim__s6* IF7(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new workMfull__add(label); 
    return blk;
}


#include "work/glbl/glbl.h"
static HSim__s6* IF8(HSim__s6 *Arch,const char* label,int nGenerics, 
va_list vap)
{
    HSim__s6 *blk = new workMglbl(label); 
    return blk;
}

class _top : public HSim__s6 {
public:
    _top() : HSim__s6(false, "_top", "_top", 0, 0, HSim::VerilogModule) {}
    HSimConfigDecl * topModuleInstantiate() {
        HSimConfigDecl * cfgvh = 0;
        cfgvh = new HSimConfigDecl("default");
        (*cfgvh).addVlogModule("full_add_sim", (HSimInstFactoryPtr)IF0);
        (*cfgvh).addVlogModule("AND2", (HSimInstFactoryPtr)IF1);
        (*cfgvh).addVlogModule("OR2", (HSimInstFactoryPtr)IF2);
        (*cfgvh).addVlogModule("XOR2", (HSimInstFactoryPtr)IF3);
        (*cfgvh).addVlogModule("XOR2", (HSimInstFactoryPtr)IF4);
        (*cfgvh).addVlogModule("OR2", (HSimInstFactoryPtr)IF5);
        (*cfgvh).addVlogModule("AND2", (HSimInstFactoryPtr)IF6);
        (*cfgvh).addVlogModule("full_add", (HSimInstFactoryPtr)IF7);
        (*cfgvh).addVlogModule("glbl", (HSimInstFactoryPtr)IF8);
        HSim__s5 * topvl = 0;
        topvl = new workMfull__add__sim("full_add_sim");
        topvl->moduleInstantiate(cfgvh);
        addChild(topvl);
        topvl = new workMglbl("glbl");
        topvl->moduleInstantiate(cfgvh);
        addChild(topvl);
        return cfgvh;
}
};

main(int argc, char **argv) {
  HSimDesign::initDesign();
  globalKernel->getOptions(argc,argv);
  HSim__s6 * _top_i = 0;
  try {
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
