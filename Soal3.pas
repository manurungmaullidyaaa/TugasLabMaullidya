program HasilStudiMahasiswa;
uses crt;

const
    MAX_MHS = 10;
    MAX_MK  = 10;

type
  // Metode pengajaran : Abstraksi. Data MK dikelompokkan 
  // dalam 1 record agar mudah dipahami sebagai 1 kesatuan. 
    TMataKuliah = record
    nama  : string[30];
    sks   : integer;
    nilai : string[2];
    skor  : real;
    end;

  // Metode pengajaran : Pemodelan Data. 
  // 1 Mahasiswa punya banyak MK, jadi pakai array of record. 
    TMahasiswa = record
    nama     : string[30];
    nim      : string[20];
    jmlMK    : integer;
    mk       : array[1..MAX_MK] of TMataKuliah;
    totalSKS : integer;
    totalSkor: real;
    ip       : real;
    end;

var
    mhs : array[1..MAX_MHS] of TMahasiswa;
    jmlMhs, i, j : integer;

// Metode pengajaran : Dekomposisi / Modular. 
// Konversi nilai huruf ke bobot dipisah jadi fungsi, 
// agar program utama lebih rapi dan mudah diuji. 
function BobotNilai(nilai : string) : real;
begin
    if nilai = 'A' then BobotNilai := 4
    else if nilai = 'B+' then BobotNilai := 3.5
    else if nilai = 'B' then BobotNilai := 3
    else if nilai = 'C+' then BobotNilai := 2.5
    else if nilai = 'C' then BobotNilai := 2
    else if nilai = 'D' then BobotNilai := 1
    else if nilai = 'E' then BobotNilai := 0
    else BobotNilai := 0;
end;

begin
    clrscr;
    writeln('PROGRAM HASIL STUDI MAHASISWA');
    writeln('=============================');
    write('Jumlah Mahasiswa : ');
    readln(jmlMhs);

  // INPUT : Metode Nested Loop
  // Loop luar untuk mahasiswa, loop dalam untuk mata kuliah.
  // Ini melatih mahasiswa berpikir 2 level sekaligus.
    for i := 1 to jmlMhs do
    begin
    writeln;
    writeln('Mahasiswa ke-', i);
    write('Nama : '); readln(mhs[i].nama);
    write('NIM  : '); readln(mhs[i].nim);
    write('Jumlah Mata Kuliah yang diambil : ');
    readln(mhs[i].jmlMK);

    mhs[i].totalSKS := 0;
    mhs[i].totalSkor := 0;

    for j := 1 to mhs[i].jmlMK do
    begin
        writeln('  Mata Kuliah ke-', j);
        write('  Nama Mata Kuliah : '); readln(mhs[i].mk[j].nama);
        write('  Jumlah SKS       : '); readln(mhs[i].mk[j].sks);
        write('  Nilai (A/B+/B/C+/C/D/E) : '); readln(mhs[i].mk[j].nilai);

      // Skor = SKS x Bobot 
        mhs[i].mk[j].skor := mhs[i].mk[j].sks * BobotNilai(mhs[i].mk[j].nilai);
        mhs[i].totalSKS := mhs[i].totalSKS + mhs[i].mk[j].sks;
        mhs[i].totalSkor := mhs[i].totalSkor + mhs[i].mk[j].skor;
    end;

    // IP = Total Skor / Total SKS
    if mhs[i].totalSKS <> 0 then
        mhs[i].ip := mhs[i].totalSkor / mhs[i].totalSKS
    else
        mhs[i].ip := 0;
    end;

  // OUTPUT : Metode Interaktif
  // Ditampilkan satu per satu dengan readkey, agar mahasiswa
  // belajar interaksi user dan kontrol alur program.
    for i := 1 to jmlMhs do
    begin
    clrscr;
    writeln('Nama : ', mhs[i].nama);
    writeln('NIM  : ', mhs[i].nim);
    writeln;
    writeln('--------------------------------------------------');
    writeln('| No | Mata Kuliah         | SKS | Nilai | Skor  |');
    writeln('--------------------------------------------------');
    for j := 1 to mhs[i].jmlMK do
    begin
        writeln('| ', j:2, ' | ', mhs[i].mk[j].nama:18, ' | ',
                mhs[i].mk[j].sks:3, ' | ', mhs[i].mk[j].nilai:4, ' | ',
                mhs[i].mk[j].skor:5:1, ' |');
    end;
    writeln('--------------------------------------------------');
    writeln('| TOTAL', ' ':33, '| ', mhs[i].totalSkor:5:1, ' |');
    writeln('--------------------------------------------------');
    writeln;
    writeln('Jumlah SKS : ', mhs[i].totalSKS);
    writeln('IP         : ', mhs[i].ip:0:2);
    writeln;

    if i < jmlMhs then
    begin
        writeln('Tekan sembarang tombol untuk melihat data selanjutnya..');
        readkey;
    end
    else
    begin
        writeln('Semua data sudah ditampilkan.');
        readkey;
    end;
    end;
end.