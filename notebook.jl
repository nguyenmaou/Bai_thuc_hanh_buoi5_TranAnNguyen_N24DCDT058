# =========================================================
# NOTEBOOK TRÌNH DIỄN BÀI THỰC HÀNH CTDLGT
# Sinh viên: Trần An Nguyên | MSSV: N24DCDT058
# =========================================================

include("TH_2026_10_09_Sinh_vien.jl")
using .GiaoDon

println(" ĐỌC DỮ LIỆU ĐẦU VÀO")
folder = mini_data()
data = read_data(folder)
p = mini_profile()
s = build_session(data.orders, data.edges, p)
GiaoDon.show_session(s)

println("\n KẾT QUẢ BFS & CHI PHÍ")
graph = adjacency(data.edges, p.tie)
bfs = bfs_routes(graph, 1)
println("Khoảng cách BFS: ", bfs.distance)
println("Chi phí thời gian các đơn: ", s.costs)

println("\n LẬP KẾ HOẠCH BẰNG KNAPSACK (DP)")
plan_res = plan!(s)
println("Tổng lợi ích tối ưu: ", plan_res.optimal.value)
println("Các đơn được chọn: ", plan_res.optimal.ids)

println("\n MÔ PHỎNG GIAO ĐƠN & HOÀN TÁC")
o1 = deliver!(s)
println("Đã giao đơn 1: ID ", o1.id)
o_undo = undo!(s)
println("Đã hoàn tác đơn: ID ", o_undo.id)

println("\n Giao toàn bộ danh sách")
while s.pending.count > 0
    deliver!(s)
end
GiaoDon.show_session(s)

println("\n XUẤT CSV")
out_path = export_result(s, joinpath(folder, "ket_qua_notebook.csv"))
println("Đã xuất file: ", out_path)