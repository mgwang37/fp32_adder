# fp32_adder
符合IEEE-754标准fp32浮点加法器(五级流水)
## 包含验证环境

cd fp32_adder/

source ./setup.bash

cd /run         

make                             ;编译 

./smoke                          ；冒烟测试

./all                            ；遍历测试

./debug     80000000  81000000   ；调试两个浮点，输入的是浮点16进制数
