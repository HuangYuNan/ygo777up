LuaR  �

             @ A@  @ �@ e   
@���@ 
@A��@ e@  
@ ��@ e�  
@�� �       require    script/c9990000 	   c9991007    initial_effect    Dazz_name_void        @   mbtg    mbop           G   F @ G@� �   ��  ]@�F�@ G � �   ]� �@� �A �@���� B �@��@� �B �@����  �@��@� �C �@���� %  �@�� D  � �@���@ � A�   �� �@DF�D G��� �A ]��@  ̀EF�E �@��@BFF �@��@AF�A �AF M���@���AF�F �@���FF�D G��@��@GF�G G���@�� HF�G GA��@�� D @ �@� � "      Dazz    VoidSynchroCommonEffect    `kcA   Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_INDESTRUCTABLE_COUNT    SetProperty    EFFECT_FLAG_SINGLE_RANGE    SetCountLimit       �?	   SetRange    LOCATION_MZONE 	   SetValue    RegisterEffect    SetDescription    aux 	   Stringid    �kcA           SetCategory    CATEGORY_REMOVE    EFFECT_FLAG_CARD_TARGET    EFFECT_TYPE_TRIGGER_O    EVENT_BATTLE_DESTROYING    SetCondition    bdocon 
   SetTarget 	   c9991007    mbtg    SetOperation    mbop              @ A@@ ��@ ��@ ���� A  �A  �   �       bit    band    REASON_BATTLE    REASON_EFFECT                     @$                                                 e           re           r           rp              _ENV         @$ G                                                	   	   	   
   
   
                                                                                                                                                               c     G      e1 	   G      e2 "   G         _ENV    $   
 F   [   ���C������  ������@ ����  @ ����� � @A����A ��A�B �� � AC ��@ �C    ���  ��A �BBƂB  � F�B �B ��A �C�� B A@� �C ��@ D  AD �  ���ƂA ǂ�C F�C � �D݃ D AD �B��BD ݂ ̂�݂ X����ƂA �B�E NC���CE � �B   �       IsControler       �?   IsLocation    LOCATION_GRAVE    IsAbleToRemove            Duel    IsExistingTarget    Card    Hint    HINT_SELECTMSG    HINTMSG_REMOVE    SelectTarget        @   SetOperationInfo    CATEGORY_REMOVE 	   GetCount    GetHandler    GetOriginalCode    �kcA   HINT_OPSELECTED    GetDescription             @$ F                                                                                                               !   !   !   !   !   !   !   !   !   !   !   !   "   "   "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   #   #   #   #   $         e     F      tp     F      eg     F      ep     F      ev     F      re     F      r     F      rp     F      chk     F      chkc     F      g .   F         _ENV %   )       @ B@A�  ��@ ��LA�BA ǂ�  @  ]���@ ��A��B FCB �B  � 
      Duel    GetChainInfo            CHAININFO_TARGET_CARDS    Filter    Card    IsRelateToEffect    Remove    POS_FACEUP    REASON_EFFECT             @$    &   &   &   &   &   '   '   '   '   '   '   (   (   (   (   (   (   )   
      e           tp           eg           ep           ev           re           r           rp           g          tc             _ENV        @$                               $      %   )   %   )             _ENV 