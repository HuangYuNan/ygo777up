LuaR  �

             @ A@  @ �@ e   
@���@ 
@A��@ e@  
@ ��@ e�  
@���@ e�  
@ ��@ e  
@���@ e@ 
@ � �       require    script/c9990000 	   c9992033    initial_effect    Dazz_name_Azorius 	   valcheck 
   condition    target 
   operation    sumsuc           H   F @ G@� �   ]� ��� �  �@�� � A �@���� �A B�@��@B  � �@�� @ �@@�   �� ̀BA� �@�̀@A �@��@CA� �@�� AA� �@�� DF�A GA��@�̀DF�A G���@�� EF�A GA��@�̀E@� �@��@B @ �@�� @ �@�   ݀ A��� A���� A���� A����A �AFA�AB ��A� �       Effect    CreateEffect    SetType       �?   SetCode      `o@	   SetValue 	   c9992033 	   valcheck    RegisterEffect    SetCategory       �@      `@   SetProperty      ��@     0�@   SetCondition 
   condition 
   SetTarget    target    SetOperation 
   operation    SetLabelObject       �@     �@   sumsuc             @$ H                                             	   	   	   
   
   
   
                                                                                                                                                                  c     H      e1    H      e2    H      e3 7   H         _ENV           � � �� �@@�@ �@A �  ����   � ��@A � �@�� ��@A � �@� �       GetMaterial 	   IsExists    Dazz 
   IsAzorius       �?	   SetLabel       Y@                    @$                                                                e           c              _ENV     #       @ � LB@]� ��@�L�@ ]� L�]� X@�  �CB  C� _  �       GetHandler    GetSummonType       �A   GetLabelObject 	   GetLabel       Y@           @$    !   !   "   "   "   "   "   "   "   "   "   "   "   "   "   #   	      e           tp           eg           ep           ev           re           r           rp           c           $   )   	     @@�FB@ G���� ��  ^�_  FB@ G��� ]B FB@ GB���  ]B FB@ G���  ��   A  �� ��  ]B� �               Duel    IsPlayerCanDraw        @   SetTargetPlayer    SetTargetParam    SetOperationInfo       �@            @$    %   %   %   %   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   (   (   (   (   (   )   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV *   -       @ B@A�  ��  � � �@ �BA�  �A� �B  �       Duel    GetChainInfo               `@      p@   Draw       P@            @$    +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   -   
      e           tp           eg           ep           ev           re           r           rp           p          d             _ENV .   ?    7   @ � LB@��  ]��[B  ��L�@]�  ��
�FBA G��� ]� ��� �B��B�� �B���� �B��B�� �B���� �B���C �B���D ��B������ �EFCE G���� � ]��B  �BBAC �B��BCA� �B�̂D@ �B� �       GetHandler    IsHasEffect        @   GetSummonType       �A   Effect    CreateEffect    SetType       �?   SetProperty        A	   SetRange       @   SetCode       E@	   SetValue 	   SetReset    ���A   RegisterEffect    Clone    SetDescription    aux 	   Stringid     �cA             �A     �D@            @$ 7   /   /   0   0   0   0   0   0   0   0   0   1   1   1   1   2   2   2   3   3   3   4   4   4   5   5   5   6   6   6   7   7   7   8   8   8   9   9   :   :   :   :   :   :   :   ;   ;   ;   <   <   <   =   =   =   ?         e     7      tp     7      eg     7      ep     7      ev     7      re     7      r     7      rp     7      c    7      e1    6      e2 &   6         _ENV        @$                                         #       $   )   $   *   -   *   .   ?   .   ?             _ENV 