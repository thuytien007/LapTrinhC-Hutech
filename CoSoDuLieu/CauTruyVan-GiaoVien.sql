GO
USE QLDT_THUYTIEN

--1.Họ tên và mức lương các giáo viên nữ
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE PHAI = N'Nữ'

--2.Họ tên và lương giáo viên sau khi tăng 10%
SELECT HOTEN, LUONG * 1.1 AS LUONG
FROM GIAOVIEN

--3 Cho biết mã gvien có họ tên bắt đầu là "Nguyễn" và lương >2000 hoặc gvien là trưởng bộ môn và nhận chức sau năm 1995
SELECT MAGV as 'Mã giáo viên'
FROM GIAOVIEN, BOMON
WHERE (HOTEN LIKE 'Nguyễn%' AND LUONG > 2000)OR (BOMON.TRUONGBM = GIAOVIEN.MAGV AND YEAR (NGAYNHANCHUC)> 1995)

--4 Cho biết tên những giáo viên khoa CNTT
SELECT gv.HOTEN
FROM GIAOVIEN as gv, BOMON as b
WHERE gv.MABM = b.MABM
and b.MAKHOA = 'CNTT'

--SELECT gv.HOTEN
--FROM GIAOVIEN as gv INNER JOIN BOMON as b ON gv.MABM = b.MABM
--WHERE b.MAKHOA = 'CNTT'

--5 Cho biết thông tin của bộ môn và thông tin giảng viên làm trưởng bộ môn đó 
SELECT *
FROM GIAOVIEN AS GV, BOMON AS BM
WHERE BM.TRUONGBM = GV.MAGV

--6 Với mỗi giáo viên cho biết thông tin của bộ môn mà họ đang làm việc
SELECT GIAOVIEN.HOTEN, BOMON.*
FROM GIAOVIEN, BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM

--7 Cho biết tên đề tài và giáo viên chủ nhiệm đề tài
SELECT HOTEN, TENDT 
FROM GIAOVIEN, DETAI
WHERE GIAOVIEN.MAGV = DETAI.GVCNDT

--8 Mỗi khoa cho biết thông tin trưởng khoa
SELECT *
FROM GIAOVIEN, KHOA
WHERE KHOA.TRUONGKHOA = GIAOVIEN.MAGV

--9 Cho biết tên các giáo viên bộ môn 'VI SINH' có tham gia đề tài 006
-- cái này nếu dùng JOIN thì k cần Distinct phải không?
SELECT DISTINCT HOTEN 
FROM GIAOVIEN, BOMON, THAMGIADT
WHERE GIAOVIEN.MABM = BOMON.MABM
AND GIAOVIEN.MAGV = THAMGIADT.MAGV
AND THAMGIADT.MADT = '006'

--10 Với những đề tài thuộc CQL 'THANH PHO' cho biết mã đề tài, thuộc chủ đề nào,
--họ tên người chủ nhiệm đề tài, ngày sinh và địa chỉ người đó.
SELECT MAGV, MADT, TENCD, HOTEN, NGSINH, DIACHI 
FROM GIAOVIEN, CHUDE, DETAI 
WHERE GIAOVIEN.MAGV = DETAI.GVCNDT
AND DETAI.MACD = CHUDE.MACD
AND DETAI.CAPQL = N'Trường'

--11 Họ tên giáo viên và người phụ trách giáo viên đó
--Truy vấn lồng
SELECT GV.HOTEN AS 'Họ tên giáo viên', B.HOTEN AS 'Tên giáo viên quản lý'
FROM GIAOVIEN AS GV,(SELECT GV1.MAGV, GV2.HOTEN 
					FROM GIAOVIEN AS GV1, GIAOVIEN AS GV2
					WHERE GV1.MAGV = GV2.GVQLCM) AS B
WHERE B.MAGV = GV.GVQLCM

--12 Tìm giáo viên được Nguyễn Thanh Tùng phụ trách trực tiếp
SELECT GV.HOTEN AS 'Họ tên giáo viên' 
FROM GIAOVIEN AS GV
WHERE GV.GVQLCM IN (SELECT GV1.MAGV 
					FROM GIAOVIEN AS GV1
					WHERE GV1.HOTEN = N'Trần Trà Hương')

--13 Cho biết tên giáo viên là trưởng bộ môn hệ thống thông tin
SELECT HOTEN
FROM GIAOVIEN, BOMON
WHERE GIAOVIEN.MAGV = BOMON.TRUONGBM  AND  BOMON.MABM = 'HTTT' 

--14 Cho"biết"tên"người"chủ nhiệm"đề tài"của"những"đề tài"thuộc"chủ đề Quản"lý"giáo"dục. 
SELECT HOTEN
FROM GIAOVIEN, DETAI, CHUDE
WHERE DETAI.MACD = CHUDE.MACD AND DETAI.GVCNDT = GIAOVIEN.MAGV AND CHUDE.TENCD = N'Quản lý giáo dục' 

--15 Cho biết "tên các công việc" của đề tài"HTTT quản lý các trường ĐH" có thời gian bắt đầu trong tháng 3/2008.
SELECT TENCV
FROM CONGVIEC, DETAI
WHERE DETAI.MADT = CONGVIEC.MADT AND DETAI.TENDT = N'HTTT quản lý các trường ĐH' AND CONGVIEC.NGAYBD BETWEEN '2008/03/01' AND '2008/03/31'

--16 Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
--Câu này giống câu 11
SELECT GV1.HOTEN AS 'Họ và Tên GV', GV2.HOTEN AS 'Họ và Tên Ql'
FROM GIAOVIEN AS GV1, (SELECT B1.MAGV, B2.HOTEN
						FROM GIAOVIEN AS B1, GIAOVIEN AS B2
						WHERE B1.MAGV = B2.GVQLCM)AS GV2
WHERE GV2.MAGV = GV1.GVQLCM

--Q17 Cho các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
SELECT TENCV
FROM CONGVIEC
WHERE NGAYBD BETWEEN '2007/01/01' AND '2007/08/01'

--Q18 Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”. 
--Coi lại dùm nhak....
SELECT HOTEN
FROM GIAOVIEN, (SELECT MABM
				FROM GIAOVIEN
				WHERE GIAOVIEN.HOTEN = N'Trần Trà Hương')AS B
WHERE GIAOVIEN.MABM = B.MABM

--19 Tìm"những"giáo viên"vừa"là"trưởng"bộ môn"vừa"chủ nhiệm"đề tài.
SELECT TRUONGBM
FROM BOMON
INTERSECT
SELECT GVCNDT
FROM DETAI

--20 Cho"biết"tên"những"giáo"viên"vừa"là"trưởng"khoa"và"vừa"là"trưởng"bộ môn.
SELECT GV.HOTEN
FROM GIAOVIEN AS GV, (SELECT TRUONGKHOA AS MAGV
						FROM KHOA
						INTERSECT 
						SELECT TRUONGBM
						FROM BOMON) AS B
WHERE GV.MAGV = B.MAGV

--21 Cho"biết"tên"những"trưởng"bộ môn"mà"vừa"chủ nhiệm"đề tài"
SELECT HOTEN
FROM GIAOVIEN AS GV,( SELECT TRUONGBM AS MAGV
				FROM BOMON
				INTERSECT
				SELECT GVCNDT
				FROM DETAI) AS B
WHERE GV.MAGV = B.MAGV

--22 Cho biết "mã số" các"trưởng khoa" có "chủ nhiệm" đề tài.SELECT TRUONGKHOAFROM KHOAINTERSECTSELECT GVCNDTFROM DETAI
--23 Cho"biết"mã"số các"giáo"viên"thuộc"bộ môn"HTTT"hoặc"có"tham"gia"đề tài"mã"001
--KHÔNG BIẾT SAO VIẾT VẦY SAI
SELECT MAGV 
FROM GIAOVIEN
WHERE MABM = 'HTTT'
UNION 
SELECT MADT
FROM THAMGIADT
WHERE MADT = '001'

--MÀ VIẾT VẦY THÌ ĐÚNG
SELECT DISTINCT GIAOVIEN.MAGV
FROM GIAOVIEN, BOMON, THAMGIADT
WHERE (GIAOVIEN.MABM = 'HTTT') OR (THAMGIADT.MADT = '001')AND GIAOVIEN.MAGV = THAMGIADT.MAGV

--24.Cho biết"giáo"viên"làm"việc"cùng"bộ môn"với"giáo"viên"002
SELECT GIAOVIEN.MAGV
FROM GIAOVIEN,(SELECT MABM
				FROM GIAOVIEN
				WHERE MAGV = '002')AS B
WHERE GIAOVIEN.MABM = B.MABM

--25.Tìm"những"giáo"viên"là"trưởng"bộ môn.
SELECT TRUONGBM
FROM BOMON 
WHERE TRUONGBM IS NOT NULL

--26.Cho"biết"họ tên"và"mức"lương"của"các"giáo"viên.
SELECT HOTEN, LUONG
FROM GIAOVIEN

--27.Cho"biết"số lượng"giáo"viên,"và"tổng"lương"của"họ.
SELECT COUNT (MAGV) AS SLGV, SUM (LUONG) AS TONG_LUONG
FROM GIAOVIEN

--28. Cho"biết"số lượng"giáo"viên"và"lương"trung"bình"của"từng"bộ môn
SELECT COUNT (MAGV)AS SLGV, MABM, AVG(LUONG) AS LTB
FROM GIAOVIEN
GROUP BY MABM

--29. Cho"biết"tên"chủ đề và"số lượng"đề tài"thuộc"về chủ đề đó.SELECT TENCD, COUNT (MADT)AS SLDT
FROM CHUDE, DETAI
WHERE DETAI.MACD = CHUDE.MACD
GROUP BY TENCD

--30.Cho"biết"tên"giáo"viên"và"số lượng"đề tài"mà"giáo"viên"đó"tham"gia
--GROUP BY chèn thêm MAGV để tránh trường hợp trùng tên
SELECT HOTEN, COUNT (MADT)AS SLDT
FROM GIAOVIEN, THAMGIADT
WHERE GIAOVIEN.MAGV = THAMGIADT.MAGV
GROUP BY HOTEN,GIAOVIEN.MAGV

--31.Cho"biết"tên"giáo"viên"và"số lượng"đề tài"mà"giáo"viên"đó"làm"chủ nhiệm
--GROUP BY chèn thêm MAGV để tránh trường hợp trùng tên
SELECT HOTEN, COUNT (MADT)AS SLDT
FROM GIAOVIEN, DETAI
WHERE GIAOVIEN.MAGV = DETAI.GVCNDT
GROUP BY HOTEN, GIAOVIEN.MAGV

--32.Với"mỗi"giáo"viên"cho"tên"giáo"viên"và"số người"thân"của"giáo"viên"đó
--GROUP BY chèn thêm MAGV để tránh trường hợp trùng tên
SELECT HOTEN, COUNT (TEN)AS SLNT
FROM GIAOVIEN, NGUOITHAN
WHERE GIAOVIEN.MAGV = NGUOITHAN.MAGV
GROUP BY HOTEN, GIAOVIEN.MAGV