clear all;
load('keys.mat')
t = [0.5, 0.5, 0.5];

Messages = cell(10,1);
Corr = zeros(10, 4);
HalfNumCount = zeros(10, 1);
P_Complete = zeros(10, 1);

RelDistPattern = zeros(10, 1);
IDsPattern = zeros(10, 1);

RelDistColor = zeros(10, 6);
IDsColor = zeros(10, 6);

%1
Messages{1} = 'Nem teljesen j�l felismerhet� 500-as f�leg sz�mok szempontj�b�l, minta k�zepesen felismerhet�, sz�n j�l felismerhet�, de m�sik 2000-es �s 10000-es is sz�ba j�het';
Corr(1,:) = [0.1, 0, 0.05, 0.4];
HalfNumCount(1,:) = 5;
P_Complete(1,:) = 0.8;

RelDistPattern(1,:) = 0.6;
IDsPattern(1,:) = 1;

RelDistColor(1,:) = [0.2, 1, 0.4, 1, 0.5, 1];
IDsColor(1,:) = [1, 2, 3, 4, 5, 6];

%2
Messages{2} = 'Nem teljesen j�l felismerhet� 500-as, minta szempontj�b�l csak a c�mer l�tszik, sz�mok j�l felismerhet�k, sz�n j�l felismerhet�, de 10000-es is sz�ba j�het';
Corr(2,:) = [0.05, 0.05, 0, 0.85];
HalfNumCount(2,:) = 6;
P_Complete(2,:) = 1;

RelDistPattern(2,:) = 0.2;
IDsPattern(2,:) = 123456;

RelDistColor(2,:) = [0.15, 1, 1, 1, 0.45, 1];
IDsColor(2,:) = [1, 2, 3, 4, 5, 6];

%3
Messages{3} = 'Rosszul felismerhet� 500-as, minta szempontj�b�l szinte semmi sem l�tszik, sz�mok nagyj�b�l felismerhet�k, de 0-val is nagy a korrel�ci�, sz�nre 500-hoz �s 2000-hez van viszonylag k�zel';
Corr(3,:) = [0.5, 0, 0.05, 0.6];
HalfNumCount(3,:) = 6;
P_Complete(3,:) = 0.9;

RelDistPattern(3,:) = 1.5;
IDsPattern(3,:) = 1;

RelDistColor(3,:) = [0.4, 1.5, 0.4, 1.5, 1.5, 1.5];
IDsColor(3,:) = [1, 2, 3, 4, 5, 6];

%4
Messages{4} = 'Nem felismerhet� 500-as, minta szempontj�b�l semmi sem l�tszik, sz�mok sem felismerhet�k, sz�nre valamennyire felismeri';
Corr(4,:) = [0, 0, 0, 0];
HalfNumCount(4,:) = 0;
P_Complete(4,:) = 1;

RelDistPattern(4,:) = 1.5;
IDsPattern(4,:) = 1;

RelDistColor(4,:) = [0.8, 1.5, 1.5, 1.5, 1.5, 1.5];
IDsColor(4,:) = [1, 2, 3, 4, 5, 6];

%5
Messages{5} = 'Nem felismerhet� 2000-es, minta szempontj�b�l semmi sem l�tszik, sz�mokn�l 0-val kezd�d�, de 5-6 f�lsz�mjegy�, sz�nre valamennyire felismeri, de 500-as is lehetne';
Corr(5,:) = [0.95, 0, 0, 0];
HalfNumCount(5,:) = 5;
P_Complete(5,:) = 0.5;

RelDistPattern(5,:) = 1.5;
IDsPattern(5,:) = 1;

RelDistColor(5,:) = [0.6, 1.5, 0.3, 1.5, 1.5, 1.5];
IDsColor(5,:) = [1, 2, 3, 4, 5, 6];

%6
Messages{6} = 'Egy�rtelm� 2000-es, minta szempontj�b�l k�zel van, sz�mokn�l egy�rtelm� a sz�moss�g, nagyon korrel�l 2-sel, de picit 0-val is, sz�nre nagyon k�zel van 2000-hez';
Corr(6,:) = [0.2, 0, 1, 0];
HalfNumCount(6,:) = 8;
P_Complete(6,:) = 1;

RelDistPattern(6,:) = 0.1;
IDsPattern(6,:) = 3;

RelDistColor(6,:) = [1, 1.5, 0.05, 1.5, 1.5, 1.5];
IDsColor(6,:) = [1, 2, 3, 4, 5, 6];

%7
Messages{7} = 'Nem l�tunk semmit';
Corr(7,:) = [0, 0, 0, 0];
HalfNumCount(7,:) = 0;
P_Complete(7,:) = 1;

RelDistPattern(7,:) = 1.9;
IDsPattern(7,:) = 1;

RelDistColor(7,:) = [1.5, 1.5, 1.5, 1.5, 1.5, 1.5];
IDsColor(7,:) = [1, 2, 3, 4, 5, 6];


for i = 1:7
    M_number = NumRecOutput2Mass(Corr(i,:), HalfNumCount(i,:), P_Complete(i,:), t, Keys);
    M_pattern = PatternOutput2Mass(RelDistPattern(i,:), IDsPattern(i,:), Keys);
    M_color = ColorOutput2Mass(RelDistColor(i,:),IDsColor(i,:),Keys);

    tmp1 = GPA(M_color, M_pattern);
    tmp2 = m_DS(tmp1);
    tmp3 = GPA(tmp2, M_number);
    M_combi = m_DS(tmp3);
    
    if(sum(cell2mat(values(M_combi))) ~= 1)
        m_values = cell2mat(values(M_combi));
        m_keys = keys(M_combi);
        m_values = m_values / sum(m_values);
        M_combi = containers.Map(m_keys,m_values);
    end;


    fprintf('\nEset: %s', Messages{i});
    fprintf('\n')
    fprintf('Mass\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative Banknote ALL\n')
    fprintf('% f', M_combi('1'), M_combi('2'), M_combi('3'), M_combi('4'), M_combi('5'), M_combi('6'), M_combi('7'), M_combi('123456'), M_combi('1234567'))

    bel = belief(M_combi);
    fprintf('\n')
    fprintf('Belief and Plausibility\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative\n')
    fprintf('% f', bel('1'), bel('2'), bel('3'), bel('4'), bel('5'), bel('6'), bel('7'))

    plaus = plausibility(M_combi);
    fprintf('\n')
    fprintf('% f', plaus('1'), plaus('2'), plaus('3'), plaus('4'), plaus('5'), plaus('6'), plaus('7'))
    fprintf('\n')
end;