LuaR  �

         G    @ @    �     �@@ �@ F�@ �  ]� G@� ] � @   @ e   
@ � @ e@  
@�� @ e�  
@ � @ e�  
@�� @ e  
@ � @ e@ 
@�� @ e� 
@ � @ e� 
@�� @ e  
@ � @ e@ 
@�� @ e� 
@ � @ e� 
@�� @ e  
@ � @ e@ 
@�� @ e� 
@ � @ e� 
@�� @ e  
@ � @ e@ 
@�� @ e� 
@ � �       Dazz    math    randomseed    require    os    time    IsCanCreateEldraziScion    CreateEldraziScion    EldraziValue    EldraziValueFilter    AddSynchroProcedureEldrazi    SynchroProcedureEldraziFilter1    SynchroProcedureEldraziFilter2    SynchroProcedureTunerFilter    SynConditionEldrazi    SynTargetEldrazi    SynOperationEldrazi    AddXyzProcedureEldrazi    XyzProcedureEldraziFilter    XyzProcedureEldraziCondition    XyzProcedureEldraziOperation    AddSynchroProcedureEndlessOne &   SynchroProcedureEndlessOneTunerFilter    SynConditionEndlessOne    SynTargetEndlessOne       
       F @ G@� �   ��  �  A �A �A � F�A �B ^  _    � 	      Duel     IsPlayerCanSpecialSummonMonster    �wcA            @�@     @@      �?   RACE_REPTILE    ATTRIBUTE_LIGHT             @$    	   	   	   	   	   	   	   	   	   	   	   	   	   
         tp              _ENV        
-   � @ �@@��  �� ��@ � � � M���݀��A �ALB ] �  LABƁB ]A�L�B�C ]A�LACƁC ]A�L�C�D �A�]A�L��� � ]A L�D]� ���E �A��A�%  �A���� �C� �A �   �       math    random       @   Duel    CreateToken    �wcA   Effect    CreateEffect    GetHandler    SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_NONTUNER    SetProperty    EFFECT_FLAG_CANNOT_DISABLE 	   SetReset    RESET_EVENT      �oA   RegisterEffect    Clone "   EFFECT_CANNOT_BE_SYNCHRO_MATERIAL 	   SetValue           
   [@  @ ��   �  � � A@ ����  �   �       IsRace    RACE_REPTILE             @$ 
                                       e     
      c     
         _ENV         @$ -                                                                                                                                                e     -      tp     -      rand    -      token 	   -      e1    -      e2 !   -         _ENV    "    
   � @ �@@ƀ@ ��� � FA �A �  � ���� @ �@��@ �@@� �A �A   A� ݀�� ��   � 	      Duel    GetMatchingGroupCount    Dazz    EldraziValueFilter    LOCATION_MZONE            `ycA    |cA       @            @$                                                                              !   !   "         c           p           v1 
         v2             _ENV #   %    	   � @ �� �   � ��@@  � ����   �    	   IsFaceup    IsHasEffect            @$ 	   $   $   $   $   $   $   $   $   %         c     	      code     	       '   2    0   @ A@@  � L�@��@ ]A�LA�AA ]A�L�A��A B ��]A�LABƁB ]A�L�B�C �A� � A� � � ]A  L�C�C �� � A� ��]A  LAD�C ǁ� � A� ��� ]A  L�D�E ]A�LAE � ]A� �       Effect    CreateEffect    SetType    EFFECT_TYPE_FIELD    SetCode    EFFECT_SPSUMMON_PROC    SetProperty    EFFECT_FLAG_UNCOPYABLE    EFFECT_FLAG_IGNORE_IMMUNE 	   SetRange    LOCATION_EXTRA    SetCondition    Dazz    SynConditionEldrazi      �X@
   SetTarget    SynTargetEldrazi    SetOperation    SynOperationEldrazi 	   SetValue    SUMMON_TYPE_SYNCHRO    RegisterEffect             @$ 0   (   (   (   (   )   )   )   *   *   *   +   +   +   +   +   ,   ,   ,   -   -   -   -   -   -   -   -   .   .   .   .   .   .   .   /   /   /   /   /   /   /   /   0   0   0   1   1   1   2         c     0      ct     0      exi     0      spo     0      e1    0         _ENV 3   6       � @ A@ ����   ����@ �� �   ����@  � ����   @�� A A A� �� � �� �   � 	      IsType    TYPE_TUNER 	   IsFaceup    IsCanBeSynchroMaterial    IsCode    �wcA   �xcA    ycA    ycA            @$    4   4   4   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   6         c           syncard              _ENV 7   :       � @ �� �   ���@@ �� �   ����@  � ����   � ���@ A ����   �       IsNotTuner 	   IsFaceup    IsCanBeSynchroMaterial    IsRace    RACE_REPTILE             @$    8   8   8   8   8   8   8   8   8   8   8   9   9   9   9   9   9   :         c           syncard              _ENV ;   A       �@  � ���΁@�@ ��  � ́�݁ ���  B���BA �@΂ �@ �� �   �       GetSynchroLevel            Clone    RemoveCard    CheckWithSumEqual    Card             @$    <   <   <   =   =   =   =   =   >   >   ?   ?   ?   @   @   @   @   @   @   @   @   @   A         c           syncard           lv           minc           maxc           g2           tlv          g2sub 
            _ENV B   ^       �   �   �        C   ]    �    � @ ��  A� ��@ ��  @��� �   @ �   � � E� [  ��FAA G��� �� B ]� �� ��@ �C  _ LA� ]� �� �   ������B �C�   � ��� ����B �BC�   � ��� @�BA �CF�B G�� ��C �C D  �� ��� BA �CF�B GB�� ��C �C D  �� ���   B  ��FD [  � �FD LB�]�  �   �F�B G�� �� ]��[   �F�B G��� ��  �E ����]��_ F�B G���� � ]����� C �B��C�Y@����E�B �DA� �  ��  �E ������ �  @ ��� � ���  �  �        IsType    TYPE_PENDULUM 	   IsFaceup    GetControler    Duel    GetFieldGroupCount            LOCATION_REMOVED 	   GetLevel    Filter    Dazz    SynchroProcedureEldraziFilter1    SynchroProcedureEldraziFilter2    GetMatchingGroup    LOCATION_MZONE    pe 	   GetOwner    SynchroProcedureTunerFilter    EldraziValue        @      �	   IsExists       �?             @$ �   D   D   D   D   E   E   E   E   E   E   E   E   E   E   E   F   F   G   G   G   G   G   G   G   G   G   G   G   G   G   G   H   H   I   J   J   K   K   K   K   K   K   K   L   L   L   L   L   L   L   L   N   N   N   N   N   N   N   N   N   N   N   O   O   O   O   O   O   O   O   O   O   O   Q   R   R   R   R   R   R   R   R   R   S   S   T   T   T   T   T   U   U   U   U   U   U   U   U   U   U   U   U   W   W   W   W   W   X   X   X   X   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   X   \   \   ]         e     �      c     �      tuner     �      mg     �      tp    �      lv !   �      g1 "   �      g2 "   �      tuner J   �      eldv k   �      (for index) n   �      (for limit) n   �      (for step) n   �      i o   �         _ENV    exi    minc    maxc         @$    ]   ]   ^         minc           maxc           exi              _ENV _   �       �   �   �        `   �    #�   @ C@�� D� �  ��̃�F�@ G��  ��݃�@�̃�F�@ GD��  ��݃���@�ƃA ����@ A@� �B �B   @�݃�@�ƃA ����@ DA@� �B �B   @�݃���ƃA �C� � F�B ݃���� A ��@ �DC	�� � �����  � �D� � A $E� @ �� �� aE�M�Y ���L���@ �F�� D  ��� � E � ]� [  @�F�D G���	�FE ǆ�� N�C��]F  F�D G�� 
� ]F�`�D  ��	�E  @ �G�C
 ���A �EF��D ǅ� �	� ��  ͅCG�
�  ����F  �E��G ����@  ��  ƅA �E��G @� ��G �E �   ��@ ��F� ݅  ̅�@� �� ��   ݅ ��@����@� ��@ �FD�� � D  ����
� E � ݅ ���I@ �E��EI݅ ��@�݅�@���I  �E���A �EGƅG  � F�G �E ��I � FJ G��F�
��  @��� �I@ �E�  ���EJ�E ̅J @ �E��� � @ ��  �  � +      Group    CreateGroup    Filter    Dazz    SynchroProcedureEldraziFilter1    SynchroProcedureEldraziFilter2    Duel    GetMatchingGroup    LOCATION_MZONE    IsPlayerAffectedByEffect    EFFECT_MUST_BE_SMATERIAL 	   GetLevel            EldraziValue        @      �	   IsExists    SynchroProcedureTunerFilter       �?   table    insert    aux 	   Stringid    �wcA      @   SelectOption    unpack    AddCard    GetSynchroLevel    Hint    HINT_SELECTMSG    HINTMSG_SMATERIAL 
   FromCards 	   GetOwner    Select    FilterSelect    Merge 	   GetFirst    Sub    SelectWithSumEqual    Card 
   KeepAlive    SetLabelObject              @$ �   a   a   a   b   c   c   d   d   d   d   d   d   d   e   e   e   e   e   e   e   e   g   g   g   g   g   g   g   g   g   g   g   h   h   h   h   h   h   h   h   h   h   h   j   j   j   j   j   k   k   k   l   l   l   l   l   m   m   m   n   n   n   o   o   o   o   p   p   p   q   q   q   q   q   q   q   q   q   q   q   q   q   r   r   r   r   r   r   r   r   r   s   s   s   s   s   o   v   w   w   w   x   x   z   z   z   z   z   z   z   {   {   }   }   ~   ~   ~                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         e     �      tp     �      eg     �      ep     �      ev     �      re     �      r     �      rp     �      chk     �      c     �      tuner     �      mg     �      g    �      g1    �      g2    �      pe 0   �      lv 3   �      tlv 3   �      eldv 8   �      selt ;   �      keyt >   �      (for index) A   a      (for limit) A   a      (for step) A   a      i B   `      mlv b   �      sel n   p      sg1 {   �      sg2 �   �         _ENV    minc    maxc         @$    �   �   �         minc           maxc              _ENV �   �       �   �   �        �   �        �  �  ���� �B��� A�  �A� �B  �BA ݂ �A��C�� �A@��� �C� ��C���C     � �  @  �� C� �       Duel    Hint 
   HINT_CARD            GetOriginalCode    GetLabelObject    SetMaterial    SendtoGrave    REASON_MATERIAL    REASON_SYNCHRO    DeleteGroup             @$     �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         e            tp            eg            ep            ev            re            r            rp            c            smat            mg            g              spo    _ENV         @$    �   �   �         minc           maxc           spo              _ENV �   �    '   F@ GA��  ]� ����@ �A���BA �A�����A �A���BB �A�����B C@� � �� �A  �A��B �C@� � �  �A  ���D �A��AD  ��A� �       Effect    CreateEffect    SetType    EFFECT_TYPE_FIELD    SetCode    EFFECT_SPSUMMON_PROC    SetProperty    EFFECT_FLAG_UNCOPYABLE 	   SetRange    LOCATION_EXTRA    SetCondition    Dazz    XyzProcedureEldraziCondition    SetOperation    XyzProcedureEldraziOperation 	   SetValue    SUMMON_TYPE_XYZ    RegisterEffect             @$ '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         c     '      lv     '      minc     '      exi     '      spo     '      e1    '         _ENV �   �       � @ ݀ �   @��@@ @� ݀��    �̀@ @� � ݀ �   � ���@ FA ݀��   �    	   IsFaceup    IsCanBeXyzMaterial    IsXyzLevel    IsRace    RACE_REPTILE             @$    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         c           xyzcard           lv              _ENV �   �       �   �   �        �   �    S    � @ �C� _ LA� Ɓ@ ]��[  @�L�� ]� [  @ �C  _ L� ]� �� �  ���AA ��A��� FB �� �� �@ ��  � �   ���    �� Y� � �� �  � � �AB�B �BA �  �� ����   ��AC�� � � �́CF�B G���  �� �݁ X��  ��A  �� � �AA ��CƁB ��� �FD �� �   @� �����   �        IsType    TYPE_PENDULUM 	   IsFaceup    GetControler    Duel    GetFieldGroupCount            LOCATION_REMOVED 	   IsExists    Dazz    XyzProcedureEldraziFilter        @	   GetCount    FilterCount    IsExistingMatchingCard    LOCATION_MZONE              @$ S   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         e     S      c     S      og     S      min     S      max     S      tp    S      count 6   E         _ENV    exi    minc    lv         @$    �   �   �         lv           minc           exi              _ENV �   �       �   �   �        �   �    M   C���@ C@F�@ G���� �A D D  � �� � [  @ ��   �F@ G����A �� B ]C LCB��  E �  ]�  �F�B G��]�� �C�� �   ��CC݃ ����D��C� �  ����  ���@ ǃ�D AD �DD� �C  �@ ǃ� �F�D �C��E@ �C��@ �C�  @ �C����  � ���   @� �C� �       Duel    GetMatchingGroup    Dazz    XyzProcedureEldraziFilter    LOCATION_MZONE            Hint    HINT_SELECTMSG    HINTMSG_XMATERIAL    Select    Group    CreateGroup 	   GetFirst    GetOverlayGroup    Merge    GetNext 
   HINT_CARD    GetOriginalCode    SendtoGrave    REASON_RULE    SetMaterial    Overlay              @$ M   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         e     M      tp     M      eg     M      ep     M      ev     M      re     M      r     M      rp     M      c     M      og     M      min     M      max     M      mg    M      sg !   M      tc #   M      sg1 '   -         _ENV    lv    minc    spo         @$    �   �   �         lv           minc           spo              _ENV �   �    *   F @ G@� �   ]� ��� �@ �@�� � AA �@���� �A FB A�@��@� �B �@���� C ACA� �� ��@  � � C ADA� �� ��@  ��� %  �@���� E �@��@E  � �@� �       Effect    CreateEffect    SetType    EFFECT_TYPE_FIELD    SetCode    EFFECT_SPSUMMON_PROC    SetProperty    EFFECT_FLAG_UNCOPYABLE    EFFECT_FLAG_IGNORE_IMMUNE 	   SetRange    LOCATION_EXTRA    SetCondition    Dazz    SynConditionEndlessOne       �?     �X@
   SetTarget    SynTargetEndlessOne    SetOperation 	   SetValue    SUMMON_TYPE_SYNCHRO    RegisterEffect    �   �       �@ ݂ C@��C��@ �@@��A �CA ��C���C  �       GetLabelObject    SetMaterial    Duel    SendtoGrave    REASON_MATERIAL    REASON_SYNCHRO    DeleteGroup             @$    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         e           tp           eg           ep           ev           re           r           rp           c           smat           mg           g             _ENV         @$ *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         c     *      e1    *         _ENV �   �       � @FA@ G���� �  � ��    �    	   IsExists    aux    TRUE             @$    �   �   �   �   �   �   �   �         c           minc           g2              _ENV �   	      �   �   �        �      `    � @ ��  A� ��@ ��  @��� �   @ �   � �    ���BA �AD  �� ��A ��   ��BA BD  �� �BB �� @ ����B ��B�AA ǁ�C FBC �BC �   � F�A ��   ��B ��B�AA ��C FBC �BC �   � FCB �� @ � �A  ��ƁC �  � �ƁC ���݁ ���  ���AA ǁ�  @� ��A ݁ �  @��AA ��  E� ��݁ � �ADFBA G��� �  � @����   �        IsType    TYPE_PENDULUM 	   IsFaceup    Filter    Dazz    SynchroProcedureEldraziFilter1    f1    SynchroProcedureEldraziFilter2    f2    Duel    GetMatchingGroup    tp    LOCATION_MZONE    pe 	   GetOwner &   SynchroProcedureEndlessOneTunerFilter 	   IsExists       �?             @$ `   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                                   e     `      c     `      tuner     `      mg     `      g1    `      g2    `      tuner <   `         _ENV    minc         @$        	        minc           maxc              _ENV 
  +      �   �   �          *   {   @ C@�� D� �   �̃�F�@ G��  ��EA ݃ @�̃�F�@ G���  ���A ݃ �����B �C��@ A@� ��B ƄB   @��EA ݃ @��B �C��@ �A@� ��B ƄB   @���A ݃ ���B ��� � FC ݃�DC � A� �  � ���C  �D����  �B ��	ED @� ��D �D �   ��@ ���	� ݄  �D�	@� �� ��   ݄ ��	�����@� ��@ �F�� � D  �� � ݄���	�DF@ 	�D���F  �D��B �D	�DD  � F�D �D �DE � E� � �  �� �DF@ 	�D���F�D �G @ �D��� �  �       Group    CreateGroup    Filter    Dazz    SynchroProcedureEldraziFilter1    f1    SynchroProcedureEldraziFilter2    f2    Duel    GetMatchingGroup    LOCATION_MZONE    IsPlayerAffectedByEffect    EFFECT_MUST_BE_SMATERIAL 	   GetLabel            AddCard    Hint    HINT_SELECTMSG    HINTMSG_SMATERIAL 
   FromCards 	   GetOwner    Select       �?   FilterSelect &   SynchroProcedureEndlessOneTunerFilter    Merge    Sub 
   KeepAlive    SetLabelObject              @$ {                                                                                                                                                                                               !  !  !  #  #  #  $  $  $  $  $  $  %  %  %  %  %  %  &  &  &  '  '  (  (  (  )  )  *        e     {      tp     {      eg     {      ep     {      ev     {      re     {      r     {      rp     {      chk     {      c     {      tuner     {      mg     {      g    {      g1    {      g2    {      pe 4   {      mlv 7   {      tlv 7   {      sg1 >   a      sg2 p   {         _ENV    minc    maxc         @$    *  *  +        minc           maxc              _ENV        @$ G                                             
                  "      #   %   #   '   2   '   3   6   3   7   :   7   ;   A   ;   B   ^   B   _   �   _   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	  �   
  +  
  +            _ENV 